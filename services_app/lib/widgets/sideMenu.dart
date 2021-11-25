import 'dart:io';
import '../themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'language_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/database_connection.dart';

class SideMenu extends StatefulWidget {
  SideMenu({Key? key}) : super(key: key);
  @override
  _SideMenuState createState() => _SideMenuState();
}

XFile? profileImage;
String profileImagePath = "assets/materiais-para-pintura.jpg";

XFile? backgroundImage;
String backgroundImagePath = "assets/materiais-para-pintura.jpg";

String? profileName;
String? address;

class _SideMenuState extends State<SideMenu> {
  ImagePicker picker = ImagePicker();

  List<String> images = [
    "assets/materiais-para-pintura.jpg",
    "assets/limpeza.jpg",
    "assets/b58b8561-dia-do-mecanico.jpg",
    "assets/faz-tudo.jpg",
  ];

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

  Future getProfileImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        profileImage = pickedFile;
        profileImagePath = profileImage!.path;
      }
    });
  }

  Future getBackgroundImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        backgroundImage = pickedFile;
        backgroundImagePath = profileImage!.path;
      }
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
                      alignment: Alignment.center,
                      child: Stack(children: [
                        Text(
                            profileName != null
                                ? profileName.toString()
                                : AppLocalizations.of(context)!.escolhaNome,
                            style: TextStyle(
                                fontFamily: defaultTheme
                                    .textTheme.bodyText1!.fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                backgroundColor: Colors.transparent,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = defaultTheme.shadowColor)),
                        Text(
                            profileName != null
                                ? profileName.toString()
                                : AppLocalizations.of(context)!.escolhaNome,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: defaultTheme
                                    .textTheme.bodyText1!.fontFamily,
                                fontSize: 22)),
                      ])),
                  SizedBox(height: 2),
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
                ],
              ),
              decoration: BoxDecoration(
                color: defaultTheme.backgroundColor,
                image: DecorationImage(
                    image: FileImage(File(backgroundImagePath)),
                    fit: BoxFit.cover),
              )),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text(AppLocalizations.of(context)!.perfil),
            onTap: () {
              Navigator.pushNamed(context, '/info');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.config),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: 300),
          Align(
              alignment: Alignment.center,
              child: Container(child: LanguagePickerWidget())),
        ],
      ),
    );
  }
}
