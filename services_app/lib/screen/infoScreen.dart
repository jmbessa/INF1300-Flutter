import 'dart:io';

import 'package:flutter/material.dart';
import '../themes.dart';
import '../widgets/sideMenu.dart';
import '../models/workers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key}) : super(key: key);
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ImagePicker picker = ImagePicker();
  FocusNode focusNode = FocusNode();

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
      backgroundImagePath = backgroundImage!.path;
    });
  }

  Future takeProfilePhoto() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        profileImage = pickedFile;
        profileImagePath = profileImage!.path;
      }
    });
  }

  Future takeBackgroundPhoto() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        backgroundImage = pickedFile;
        backgroundImagePath = profileImage!.path;
      }
    });
  }

  Future setProfileName() async {
    String name = TextInputType.text as String;
    setState(() {
      profileName = name;
    });
  }

  void pickImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(children: [
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text(AppLocalizations.of(context)!.camera),
          onTap: () {
            Navigator.pop(context);
            takeProfilePhoto();
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text(AppLocalizations.of(context)!.galeria),
          onTap: () {
            Navigator.pop(context);
            getProfileImage();
          },
        ),
      ]),
    );
  }

  Widget _buildProfileName() {
    return TextField(
      decoration: InputDecoration(
          labelText: profileName != null
              ? profileName.toString()
              : AppLocalizations.of(context)!.escolhaNome,
          floatingLabelBehavior: FloatingLabelBehavior.never),
      maxLength: 40,
      onChanged: (value) {
        profileName = value;
      },
    );
  }

  Widget _buildAddress() {
    return TextField(
      focusNode: focusNode,
      decoration: InputDecoration(
          labelText: address != null
              ? address.toString()
              : AppLocalizations.of(context)!.insereEndereco,
          floatingLabelBehavior: FloatingLabelBehavior.never),
      maxLength: 40,
      onChanged: (value) {
        address = value;
      },
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton.extended(
      backgroundColor: defaultTheme.primaryColor,
      onPressed: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      label: Text(AppLocalizations.of(context)!.alteraBtn),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: SizedBox(
                child: Text(
                  AppLocalizations.of(context)!.alteraNome,
                  style: defaultTheme.textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: _buildProfileName(),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(25, 0, 25, 5),
              child: SizedBox(
                child: Text(
                  AppLocalizations.of(context)!.alteraFoto,
                  style: defaultTheme.textTheme.bodyText1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                pickImage(context);
              },
              child: CircleAvatar(
                radius: 47,
                backgroundColor: defaultTheme.shadowColor,
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
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 5),
              child: SizedBox(
                child: Text(
                  AppLocalizations.of(context)!.alteraFundo,
                  style: defaultTheme.textTheme.bodyText1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                pickImage(context);
              },
              child: Container(
                height: 200,
                width: 200,
                color: defaultTheme.shadowColor,
                child: Card(
                  child: backgroundImage != null
                      ? Image.file(File(backgroundImagePath))
                      : Icon(Icons.camera_alt, color: Colors.grey[800]),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: SizedBox(
                child: Text(
                  AppLocalizations.of(context)!.alteraEndereco,
                  style: defaultTheme.textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: _buildAddress(),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
      floatingActionButton: showFab ? _buildFloatingButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
