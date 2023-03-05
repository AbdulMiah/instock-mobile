import 'package:flutter/material.dart';

class CommonTheme {
  static const greenColor = Color(0xff2FD4A3);
  static const blackColor = Color(0xff000000);
  static const whiteColor = Color(0xffFFFFFF);
  static const pinkColor = Color(0xffEA5480);
  ThemeData themeData = ThemeData(
    primaryColorDark: blackColor,
    primaryColorLight: whiteColor,
    splashColor: greenColor,
    highlightColor: pinkColor,
    textTheme: const TextTheme(
      //White Text
      displayLarge: TextStyle(
          color: whiteColor, fontSize: 48, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: whiteColor, fontSize: 36),
      displaySmall: TextStyle(color: whiteColor, fontSize: 18),
      // Dark Text
      bodyLarge: TextStyle(
          color: blackColor, fontSize: 48, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: blackColor, fontSize: 36),
      headlineMedium: TextStyle(
          color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: blackColor, fontSize: 18),
      // Error Message
      headlineSmall: TextStyle(color: pinkColor, fontSize: 18),
    ),
  );
}