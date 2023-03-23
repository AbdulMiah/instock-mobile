import 'package:flutter/material.dart';

class CommonTheme {
  static const greenColor = Color(0xff2FD4A3);
  static const blackColor = Color(0xff000000);
  static const whiteColor = Color(0xffFFFFFF);
  static const pinkColor = Color(0xffEA5480);
  static const offWhiteColor = Color(0xffD9D8D8);

  // OffWhiteColor was d9d8d8 - made it 10% lighter
  static const offWhiteColor = Color(0xffdddcdc);

  EdgeInsets textFieldPadding = const EdgeInsets.fromLTRB(0, 24.0, 0, 0);
  ThemeData themeData = ThemeData(
    primaryColorDark: blackColor,
    primaryColorLight: whiteColor,
    splashColor: greenColor,
    highlightColor: pinkColor,
    cardColor: offWhiteColor,
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

      titleMedium: TextStyle(
          color: blackColor, fontSize: 24, fontWeight: FontWeight.bold),
      // Error Message
      headlineSmall: TextStyle(color: pinkColor, fontSize: 18),
      // Success Message
      labelSmall: TextStyle(color: greenColor, fontSize: 18),

      labelMedium: TextStyle(
          color: blackColor, fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
