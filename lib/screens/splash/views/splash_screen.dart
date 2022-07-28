import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketitik/screens/homescreen/view/home_screen.dart';
import 'package:ketitik/screens/prefrences/views/prefrence_screen.dart';
import 'package:ketitik/utility/application_utils.dart';
import 'package:ketitik/utility/prefrence_service.dart';

import '../../auth/controller/login_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var controller = Get.find<LoginController>();
  PrefrenceService prefrenceService = PrefrenceService();
  @override
  void initState() {
    getBoolStatus();
    super.initState();
  }

  getBoolStatus() async {
    bool status = await prefrenceService.getPreferenceSaved();
    String deviceToken = ApplicationUtils.getDeviceId();
    prefrenceService.setDeviceId(deviceToken);
    String? token = await prefrenceService.getToken();
    print("login status $status");
    print("logstat token : $token");
    Timer(const Duration(seconds: 3), () {
      prefrenceService.setDeviceId(deviceToken);
      Get.off(
        () => status ? MyHomePage() : PrefrenceScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthscreen = MediaQuery.of(context).size.width;
    double heightscreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.all(10),
        width: widthscreen,
        height: heightscreen,
        child: Image.asset(
          'assets/images/ketsquarezoom.png',
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
