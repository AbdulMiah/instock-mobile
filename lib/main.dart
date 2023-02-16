import 'package:flutter/material.dart';
import 'package:instock_mobile/src/presentation/home_page.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColorDark: blackColor,
        primaryColorLight: whiteColor,
        splashColor: greenColor,
        highlightColor: pinkColor,
      ),
      home: const HomePage(title: 'InStock V3'),
    );
  }
}


