import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:ketitik/screens/auth/controller/login_controller.dart';
import 'package:ketitik/utility/colorss.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utility/social_credentials.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<LoginController>();
  bool isSignIn = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    controller.googleSignIn.signOut();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: MyColors.themeColor
              /*image: DecorationImage(
                  //image: AssetImage("assets/images/ketiback.png"),
                  fit: BoxFit.cover)),*/
              ),
          padding: const EdgeInsets.all(10),
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /*Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  child: const Text(
                    'SKIP',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      shape: const StadiumBorder()),
                  onPressed: () {
                    Get.to(() => MyHomePage.withA());
                  },
                ),
              ),*/
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/ketsquarezoom.png',
                width: 200,
                height: 200,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13.0),
                child: SignInButton(
                  Buttons.Google,
                  elevation: 6.0,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    controller.signInWithGoogle();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13.0),
                child: SignInButton(
                  Buttons.Facebook,
                  elevation: 6.0,
                  text: "Sign in with Facebook",
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    controller.facebookLogin();
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              // if(Platform.isIOS)
              Card(
                margin: const EdgeInsets.only(
                    top: 0.0, left: 13.0, right: 13.0, bottom: 2.0),
                elevation: 6.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: SignInWithAppleButton(
                    style: SignInWithAppleButtonStyle.white,
                    height: 35.0,
                    onPressed: () async {
                      controller.appleLogin();
                      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                      // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'By clicking Log in, you agree with our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy.\n We never post to Facebook',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onLogin() async {
    final twitterLogin = TwitterLogin(
        apiKey: SocialCrendentials().apiKeyTwitter,
        apiSecretKey: SocialCrendentials().apiSecretKey,
        redirectURI: SocialCrendentials().redirectURI);
    await twitterLogin.login().then(
      (value) async {
        final twitterAuthCredentials = TwitterAuthProvider.credential(
            accessToken: value.authToken.toString(),
            secret: value.authTokenSecret.toString());
        print(value.authToken.toString());
        await FirebaseAuth.instance
            .signInWithCredential(twitterAuthCredentials);
      },
    );
  }
}
