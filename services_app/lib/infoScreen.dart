import 'dart:io';

import 'package:flutter/material.dart';
import 'themes.dart';
import 'widgets/sideMenu.dart';
import 'workers.dart';
import 'package:image_picker/image_picker.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key}) : super(key: key);
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ImagePicker picker = ImagePicker();
  Future getProfileImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      profileImage = pickedFile;
      profileImagePath = profileImage!.path;
    });
  }

  Future getBackgroundImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      backgroundImage = pickedFile;
      backgroundImagePath = profileImage!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: defaultTheme.backgroundColor,
          leading: BackButton(color: defaultTheme.backgroundColor),
          elevation: 0,
          title: Text(
            "Profile Info",
            style: TextStyle(color: defaultTheme.backgroundColor),
          ),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () async {
                getProfileImage();
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: defaultTheme.primaryColor,
                child: profileImage != null
                    ? ClipOval(
                        child: Image.file(File(profileImagePath),
                            fit: BoxFit.cover, width: 90, height: 90))
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                getBackgroundImage();
              },
              child: Container(
                height: 200,
                width: 200,
                color: Colors.green,
                child: Card(
                  child: backgroundImage != null
                      ? Image.file(File(backgroundImagePath))
                      : Container(
                          decoration: BoxDecoration(color: Colors.red),
                        ),
                ),
              ),
            )
          ],
        ));
  }
}
