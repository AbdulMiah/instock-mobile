import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/navigation/navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const greenColor = Color(0xff2FD4A3);
    const blackColor = Color(0xff000000);
    const whiteColor = Color(0xffFFFFFF);
    const pinkColor = Color(0xffEA5480);

    return MaterialApp(
      //Removes Debug Banner
      debugShowCheckedModeBanner: false,

      title: 'Instock',
      theme: ThemeData(
        // Colours
        primaryColorDark: blackColor,
        primaryColorLight: whiteColor,
        splashColor: greenColor,
        highlightColor: pinkColor,

        //Text
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: whiteColor, fontSize: 48, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: whiteColor, fontSize: 48),
          displaySmall: TextStyle(color: whiteColor, fontSize: 18),
        ),
      ),

      home: const NavBar(),
    );
  }
}
