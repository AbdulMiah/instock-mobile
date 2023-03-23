import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:instock_mobile/src/features/auth_check.dart';

import 'injection.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp();
    // Notif.initialize(flutterLocalNotificationsPlugin);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const greenColor = Color(0xff2FD4A3);
    const blackColor = Color(0xff000000);
    const whiteColor = Color(0xffFFFFFF);
    const pinkColor = Color(0xffEA5480);

    return MaterialApp(
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
          //White Text
          displayLarge: TextStyle(
              color: whiteColor, fontSize: 48, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: whiteColor, fontSize: 36),
          displaySmall: TextStyle(color: whiteColor, fontSize: 18),
          // Dark Text
          bodyLarge: TextStyle(
              color: blackColor, fontSize: 48, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: blackColor, fontSize: 36),
          bodySmall: TextStyle(color: blackColor, fontSize: 18),
          // Error Message
          headlineSmall: TextStyle(color: pinkColor, fontSize: 18),
        ),
      ),
      home: AuthCheck(),
    );
  }
}
