import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:instock_mobile/src/features/auth_check.dart';
import 'package:instock_mobile/src/features/inventory/screens/item_details_page.dart';

import '../../features/inventory/data/item.dart';

class NotificationService {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (response) async {
      print('notification payload: ${response.payload}');
      if (response.payload != null) {
        final item = Item.fromJson(jsonDecode(response.payload as String));
        await Get.to(() => AuthCheck(ItemDetails(item: item)));
      }
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService.showNotification(
          message: message, fln: flutterLocalNotificationsPlugin);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data != null) {
        final response = jsonEncode(message.data);
        final item = Item.fromJson(jsonDecode(response));
        await Get.to(() => AuthCheck(ItemDetails(item: item)));
      }
    });
  }

  static Future showNotification(
      {var id = 0,
      required RemoteMessage message,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'InStockChannelId',
      'Stock Notifications',
      playSound: true,
      importance: Importance.high,
      priority: Priority.high,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());

    await fln.show(id, message.notification?.title, message.notification?.body,
        platformChannelSpecifics,
        payload: jsonEncode(message.data));
  }
}
