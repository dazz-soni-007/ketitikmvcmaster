import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:ketitik/screens/auth/views/register_screen.dart';
import 'package:ketitik/screens/prefrences/views/prefrence_screen.dart';
import 'package:ketitik/utility/prefrence_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../services/api_service.dart';
import '../../../utility/application_utils.dart';
import '../views/login_screen.dart';

class LoginController extends GetxController {
  final googleSignIn = GoogleSignIn();
  var googleAcc = Rx<GoogleSignInAccount?>(null);
  var isLoading = false.obs;
  PrefrenceService prefrenceService = PrefrenceService();
  Rx<bool> isLoggedIn = false.obs;
  Dio dio = Dio();
  String deviceId = "";

  void signInWithGoogle() async {
    final _prefrence = PrefrenceService();
    try {
      isLoading.value = true;
      deviceId = await ApplicationUtils.getDeviceDetails();
      googleAcc.value = await googleSignIn.signIn().then((value) async {
        print("------ Device Id : $deviceId");
        ApplicationUtils.openDialog();

        var loginDb = await loginToDB(value!.email, value.id, deviceId);
        isLoggedIn.value = loginDb["status"];

        prefrenceService.setLoggedIn(loginDb["status"]);

        print("Google Acc : ${isLoggedIn.value}");
        print("Google Acc : $value");

        var googleKey = await value.authentication;
        print("Google Key : ${googleKey.accessToken}");

        print("loginDb: $loginDb");

        if (loginDb['status'] == true) {
          // ApplicationUtils.closeDialog();

          _prefrence.setName(loginDb['data']['name']);
          _prefrence.setEmail(loginDb['data']['email']);
          //_prefrence.setPhone(loginDb['data']['contact']);
          _prefrence.setToken(loginDb['token']);

          ApplicationUtils.closeDialog();

          Get.to(() => PrefrenceScreen());
        } else {
          ApplicationUtils.closeDialog();

          print(" Display Name : ${value.displayName}");
          Get.to(() => RegisterScreen(
                name: value.displayName,
                emailID: value.email,
                socialID: value.id,
              ));
        }

        update();
        return value;
      });
    } catch (e) {
      ApplicationUtils.closeDialog();
      print("Errorrr => ${e.toString()}");
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black54,
          colorText: Colors.white);
    }
  }

  loginToDB(String emailID, String socialID, String deviceId) async {
    try {
      final url = Uri.parse(APIService.login);

      Map<String, dynamic> mapData = {
        "email": emailID,
        "device_id": deviceId,
        "social_id": socialID,
      };
      print("Data Body: ${mapData.toString()}");

      var response = await http.post(url, body: mapData);

      print("Data: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        print("Data: $data");
        update();
        return data;
      } else {
        var data = json.decode(response.body);
        return data;
      }
    } on DioError catch (error) {
      print("Catch : ${error.toString()}");
    }
  }

  registerToDB(String emailID, String socialID, String name, String deviceID,
      String contactNumber) async {
    deviceId = await ApplicationUtils.getDeviceDetails();
    final url = Uri.parse(APIService.register);
    Map<String, dynamic> mapData = {
      "email_id": emailID,
      "social_id": socialID,
      "name": name,
      "device_id": deviceId,
    };
    try {
      var response = await http.post(url, body: mapData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var postData = json.decode(response.body);
        print("Post Data : $postData");
        update();
        return postData;
      } else {
        return null;
      }
    } catch (e) {
      print("Catch Error : ${e.toString()}");
      return e;
    }
  }

  signOut() async {
    try {
      googleAcc.value = await googleSignIn.signOut();
      if (googleAcc.value == null) {
        Get.to(() => const LoginScreen());
      } else {
        return;
      }
      update();
    } catch (e) {
      return e;
    }
  }

  void appleLogin() async {
    deviceId = await ApplicationUtils.getDeviceDetails();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
    );

    print("Identifier :: ${credential.userIdentifier}");
    print("Identifier :: ${credential.authorizationCode}");
    print("Identifier :: ${credential.identityToken}");

    ApplicationUtils.openDialog();
    var loginDb =
        await loginToDB("", credential.userIdentifier.toString(), deviceId);
    isLoggedIn.value = loginDb["status"];

    prefrenceService.setLoggedIn(loginDb["status"]);

    print("FB Acc : ${isLoggedIn.value}");
    print("FB Acc : ${credential.givenName.toString()}");

    print("loginDb: $loginDb");

    if (loginDb['status'] == true) {
      final _prefrence = PrefrenceService();

      _prefrence.setName(loginDb['data']['name']);
      _prefrence.setEmail(loginDb['data']['email']);
      _prefrence.setToken(loginDb['token']);

      ApplicationUtils.closeDialog();

      Get.to(() => PrefrenceScreen());
    } else {
      ApplicationUtils.closeDialog();
      var email = credential.email.toString();
      print(" Display Name : ${credential.givenName.toString()}");
      Get.to(() => RegisterScreen(
            name: credential.givenName.toString(),
            emailID: email == null ? "" : email,
            socialID: credential.userIdentifier.toString(),
          ));
    }
  }

  void facebookLogin() async {
    List<String> permissionsReq = const ['email', 'public_profile'];
    LoginResult result =
        await FacebookAuth.instance.login(permissions: permissionsReq);
    switch (result.status) {
      case LoginStatus.success:
        deviceId = await ApplicationUtils.getDeviceDetails();
        print("success");

        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken!.token}'));

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        print("User : ${profile['name']}");
        var socialId = profile['id'];
        var userName = profile['name'];

        ApplicationUtils.openDialog();
        var loginDb = await loginToDB("", socialId, deviceId);
        isLoggedIn.value = loginDb["status"];

        prefrenceService.setLoggedIn(loginDb["status"]);

        print("FB Acc : ${isLoggedIn.value}");
        print("FB Acc : $userName");

        print("loginDb: $loginDb");

        if (loginDb['status'] == true) {
          final _prefrence = PrefrenceService();

          _prefrence.setName(loginDb['data']['name']);
          _prefrence.setEmail(loginDb['data']['email']);
          //_prefrence.setPhone(loginDb['data']['contact']);
          _prefrence.setToken(loginDb['token']);

          ApplicationUtils.closeDialog();

          Get.to(() => PrefrenceScreen());
        } else {
          ApplicationUtils.closeDialog();

          print(" Display Name : ${userName}");
          Get.to(() => RegisterScreen(
                name: userName,
                emailID: "",
                socialID: socialId,
              ));
        }
        break;
      case LoginStatus.cancelled:
        ApplicationUtils.closeDialog();
        print("CANcelled ${result.message}");
        break;
      case LoginStatus.operationInProgress:
        print("inProgress ${result.message}");
        break;
      default:
        break;
    }
  }
}

class Resources {
  Status? status;

  Resources({this.status});
}

enum Status { Success, Error, Cancel }
