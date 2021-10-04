import 'package:flutter/material.dart';
import 'themes.dart';
import 'widgets/sideMenu.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color positiveColor = new Color(0xFFEF0078);
  Color negativeColor = new Color(0xFFFFFFFF);
  double percentage = 0;

  double initial = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Nome',
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profilePicture.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            GestureDetector(
              onPanStart: (DragStartDetails details) {
                initial = details.globalPosition.dx;
              },
              onPanUpdate: (DragUpdateDetails details) {
                double distance = details.globalPosition.dx - initial;
                if (distance > -20) _scaffoldKey.currentState?.openEndDrawer();
                double percentageAddition = distance / 200;
                setState(() {
                  percentage = (percentage + percentageAddition).clamp(0, 100);
                });
              },
              onPanEnd: (DragEndDetails details) {
                initial = 0;
              },
            ),
          ],
        ));
  }
}
