import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HelperNotification{
  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (response) async {
          print('notification payload: ${response.payload}');
        }
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    
    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
      print("=========== onMessage ===========");
      print("onMessage: ${message.notification?.title}/${message.notification?.body}");
      
      HelperNotification.showNotification(message: message, fln: flutterLocalNotificationsPlugin);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("=========== onOpenApp ===========");
      print("onOpenApp: ${message.notification?.title}/${message.notification?.body}");
    });
  }

  static Future showNotification({
      var id = 0, required RemoteMessage message, var payload, required FlutterLocalNotificationsPlugin fln
    }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
      'instock',
      'instock_channel',

      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.high,
      priority: Priority.high,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails()
    );
    await fln.show(
        0, message.notification?.title, message.notification?.body,
        platformChannelSpecifics, payload: "payload"
    );
  }
}