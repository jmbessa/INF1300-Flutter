import 'package:flutter/material.dart';

final ThemeData defaultTheme = _buildDefaultTheme();

ThemeData _buildDefaultTheme() {
  return ThemeData(
    primaryColor: Colors.teal,
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
