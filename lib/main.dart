import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:instock_mobile/src/features/auth_check.dart';
import 'package:instock_mobile/src/features/navigation/navigation_bar.dart';
import 'package:instock_mobile/src/utilities/services/notification_service.dart';

import 'firebase_options.dart';
import 'injection.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  print("=========== onBackground ===========");
  print("onBackground: ${message.notification?.title}/${message.notification?.body}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await messaging.getInitialMessage();
    await NotificationService.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch(e) {}

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
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

    return GetMaterialApp(
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
      home: AuthCheck(const NavBar()),
    );
  }
}
