import 'package:flutter/material.dart';

final ThemeData defaultTheme = _buildDefaultTheme();
final ThemeData buttonTheme = _buildButtonTheme();

ThemeData _buildButtonTheme() {
  return ThemeData(
      primaryColor: Colors.teal,
      textTheme: TextTheme(
          bodyText1: const TextStyle(
              fontFamily: "Helvetica",
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16)));
}

ThemeData _buildDefaultTheme() {
  return ThemeData(
    primaryColor: Colors.teal,
    backgroundColor: Colors.black,
    buttonColor: Colors.teal,
    textTheme: TextTheme(
      bodyText1: const TextStyle(
        fontSize: 18,
        fontFamily: "Helvetica",
        fontWeight: FontWeight.bold,
      ),
      bodyText2: const TextStyle(fontSize: 15, fontFamily: "Helvetica"),
    ),
  );
}
