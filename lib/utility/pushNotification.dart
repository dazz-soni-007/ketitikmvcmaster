import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../screens/bookmark/detail_page_noti.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //var ring = true;
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'com.app.ketitik.ketitik', // id
    'High Importance Notifications',
    importance: Importance.high,
  );
  //RemoteNotification? notification = message.notification;
  final data = message.data;
  print('onBackgroundMessage received: $data');
  var _data = jsonDecode(data["news_id"]);
  String title = data["title"];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  AppleNotification? apple = message.notification?.apple;

  if (Platform.isIOS) {
    if (notification != null && apple != null) {
      pushlogtofirebase("PlatForm ${message.data.toString()} ${message.notification.toString()}");
    }
  } else {
    flutterLocalNotificationsPlugin.show(
        title.hashCode,
        title,
        "",
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            importance: Importance.max,
            priority: Priority.high,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: "@mipmap/ic_ketitiknew",
            largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_ketnew'),
          ),
        ),
        payload: _data.toString());
    print('onBackgroundMessage received: $message');
    print(message.data.toString());
  }
}

void pushlogtofirebase(String logger) {
  final _firestore = FirebaseFirestore.instance;
  _firestore
      .collection('Notification')
      .add({"message": "${logger.toString()}"}).then(
          (value) => print('Success $value'));
}

class PushNotificationService {

  static Future<void> cancelNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // AudioPlayer player;

  Future initialise(BuildContext context) async {
    _firebaseMessaging.requestPermission();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.app.ketitik.ketitik', // id
      'High Importance Notifications',
      importance: Importance.max,
      enableLights: true,
      // 'This channel is used for important notifications.', // description
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //RemoteNotification? notification = message.notification;
      print("On Message " + message.data.toString());
      final data = message.data;
      var _data = jsonDecode(data["news_id"]);
      print("On Message Id" + _data.toString());
      String title = data["title"];
      print("On Message Title test" + title);

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;

      if (Platform.isIOS) {
        if (notification != null && apple != null) {
          pushlogtofirebase("Custom ${message.data} ${message.notification}");
          flutterLocalNotificationsPlugin.show(
              title.hashCode,
              title,
              "",
              NotificationDetails(
                  iOS: IOSNotificationDetails(
                presentAlert: true,
                // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                presentBadge: true,
                // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                presentSound: true,
                // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                badgeNumber: 1, // The application's icon badge number)
              )),
              payload: _data.toString());
        }
      } else {
        flutterLocalNotificationsPlugin.show(
            title.hashCode,
            title,
            "",
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                importance: Importance.max,
                priority: Priority.high,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_ketitiknew",
                largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_ketnew'),
              ),
            ),
            payload: _data.toString());
        print('onBackgroundMessage received: $message');
        print(message.data.toString());
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");

        if (message != null) {
          var _data = "";
          final data = message.data;
          _data = jsonDecode(data["news_id"]);
          print("Sorted Notifiction Bundle :: $_data");
          print("clicked on notification ${message.data}");
          if (_data == "") {
          } else {
            Get.to(NotificationDetailPage(_data.toString()));
          }
          //notificationController.getNotificationList();
          print("New Notification");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final data = message.data;
      var _data = jsonDecode(data["news_id"]);
      //var title = jsonDecode(data["title"]);
      print("Sorted Notifiction Bundle :: $_data");
      print("clicked on notification ${message.data}");
      Get.to(NotificationDetailPage(_data.toString()));
    });

    //Get.to(NotificationDetailPage("id"));

    //_firebaseMessaging.requestPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
  }
}
