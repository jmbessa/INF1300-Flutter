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
        key: _scaffoldKey,
        endDrawer: SideMenu(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'CUSTOM SLIDER',
            style: TextStyle(color: positiveColor),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              percentage.round().toString() + '%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 70,
                color: positiveColor,
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
              child: CustomSlider(
                percentage: this.percentage,
                positiveColor: positiveColor,
                negativeColor: negativeColor,
              ),
            ),
          ],
        )));
  }
}

class CustomSlider extends StatelessWidget {
  double totalWidth = 200;
  double? percentage;
  Color? positiveColor;
  Color? negativeColor;

  CustomSlider({this.percentage, this.positiveColor, this.negativeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: totalWidth + 4,
      height: 30,
      decoration: BoxDecoration(
          color: negativeColor,
          border: Border.all(color: Colors.black, width: 2)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            color: positiveColor,
            width: (percentage! / 100) * totalWidth,
          ),
        ],
      ),
    );
  }
}
