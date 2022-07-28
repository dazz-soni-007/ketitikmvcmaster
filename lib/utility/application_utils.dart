import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApplicationUtils {
  static Future<void> openDialog() async {
    showDialog(
        context: Get.overlayContext!,
        builder: (_) => WillPopScope(
              //onWillPop: () {  },
              child: const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ),
                ),
              ),
              onWillPop: () async => false,
            ));
  }

  static String getAvatarImage(String id) {
    String avatarPath = "";
    if (id == "0") {
      avatarPath = "assets/images/menavatarnew.png";
    } else if (id == "1") {
      avatarPath = "assets/images/boyavatar.png";
    } else if (id == "2") {
      avatarPath = "assets/images/ladyavatar.png";
    } else if (id == "3") {
      avatarPath = "assets/images/girlavatar.png";
    }
    return avatarPath;
  }

  static popCurrentPage(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  static Future<String> getDeviceDetails() async {
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return identifier!;
  }

  static onBackPress(BuildContext context) {
    Navigator.pop(context, true);
  }

  static Future<bool> isOnline() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Connected!');
    } else {
      print('No internet :( Reason:');
    }
    return result;
  }

  static String getDeviceId() {
    String deviceId = "";

    _getId().then((id) {
      deviceId = id!;
    });

    return deviceId;
  }

  static Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // Unique ID on Android
    }
  }

  static Future<void> closeDialog() async {
    Navigator.of(Get.overlayContext!).pop();
  }
}
