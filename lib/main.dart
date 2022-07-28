import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ketitik/screens/auth/binding/login_binding.dart';
import 'package:ketitik/screens/bookmark/detail_page_noti.dart';
import 'package:ketitik/screens/homescreen/view/home_screen.dart';
import 'package:ketitik/utility/app_route.dart';
import 'package:ketitik/utility/colorss.dart';
import 'package:ketitik/utility/pushNotification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCKpKl1U49Si1Q-r9mu12mdDBzpeH60reo",
            appId: "Your app id found in Firebase",
            messagingSenderId: "Your Sender id found in Firebase",
            projectId: "ketitik-a4e98"));
  } else {
    await Firebase.initializeApp();
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  HttpOverrides.global = new MyCustomHttpOverrides();
  runApp(const MyApp());
}

class MyCustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });

  String? title;
  String? body;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

parseNotificationData(Map<String, dynamic> response) {
  var _data = jsonDecode(response["news_id"]);

  print("Sorted Notifiction Bundle :: $_data");
}

class _MyAppState extends State<MyApp> {
  PushNotificationService pushNotificationService = PushNotificationService();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  initialiseBackgroundMode() async {
    final androidConfig = FlutterBackgroundAndroidConfig(
      notificationImportance: AndroidNotificationImportance.High,
      enableWifiLock: true,
      notificationIcon: AndroidResource(
          name:
              'mipmap/ic_ketitiknew'), // Default is ic_launcher from folder mipmap
    );
    bool success = await FlutterBackground.enableBackgroundExecution();
    if (success) {
    } else {
      await FlutterBackground.initialize(androidConfig: androidConfig);
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
    /*  var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_ketitiknew');

    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    launchDetails(context);*/
    //initialiseBackgroundMode();
  }

  String? token;

  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
  }

  parseNotificationData(Map<String, dynamic> response) {
    var _data = jsonDecode(response["news_id"]);
    print("Sorted Notifiction Bundle :: $_data");
  }

  @override
  Widget build(BuildContext context) {
    //pushNotificationService.initialise(context);
    return GetMaterialApp(
      initialBinding: LoginBinding(),
      title: 'KeTitik',
      navigatorKey: navigatorKey,
      initialRoute: RoutingNameConstants.SPLASH_SCREEN_ROUTE,
      getPages: AppRoute.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColors.themeColorYellow,
        colorScheme: ColorScheme.fromSwatch(accentColor: Colors.black),
        primarySwatch: Colors.yellow,
        fontFamily: 'Montserrat',
      ),
      // home: ProfilePage(),
    );
  }

  void onSelectNotification(String? payload) {
    print("Normal Call :: Notification");
    Get.to(NotificationDetailPage(payload.toString()));
  }

  launchDetails(BuildContext context) async {
    final notificationOnLaunchDetails = await FlutterLocalNotificationsPlugin()
        .getNotificationAppLaunchDetails();
    if (notificationOnLaunchDetails?.didNotificationLaunchApp ?? false) {
      onSelectNotification(notificationOnLaunchDetails!.payload);
    }
  }

  void onSelectNotificationTerminated(String? payload) {
    print("Terminated Call :: Notification");
    Get.to(MyHomePage.withNotification(
      foo: payload,
    ));
    //Get.to(NotificationDetailPage(payload.toString()));
  }
}
