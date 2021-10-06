import 'dart:io';
import '../themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SideMenu extends StatefulWidget {
  SideMenu({Key? key}) : super(key: key);
  @override
  _SideMenuState createState() => _SideMenuState();
}

XFile? profileImage;
String profileImagePath = "assets/materiais-para-pintura.jpg";

XFile? backgroundImage;
String backgroundImagePath = "assets/materiais-para-pintura.jpg";

class _SideMenuState extends State<SideMenu> {
  ImagePicker picker = ImagePicker();

  List<String> images = [
    "assets/materiais-para-pintura.jpg",
    "assets/limpeza.jpg",
    "assets/b58b8561-dia-do-mecanico.jpg",
    "assets/faz-tudo.jpg",
  ];

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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  SizedBox(height: 2),
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
                ],
              ),
              decoration: BoxDecoration(
                color: defaultTheme.backgroundColor,
                image: DecorationImage(
                    image: FileImage(File(backgroundImagePath)),
                    fit: BoxFit.cover),
              )),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/info');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
