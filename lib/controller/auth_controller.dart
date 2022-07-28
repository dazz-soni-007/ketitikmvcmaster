import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ketitik/utility/app_route.dart';

class AuthController extends GetxController {
  late GoogleSignIn googleSignIn;
  var isSign = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() async {
    googleSignIn = GoogleSignIn();
    ever(isSign, handleAuth);
    isSign.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      print("event : $event");
      isSign.value = event != null;
    });
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  handleAuth(bool callback) {
    print("Callback $callback");
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (callback) {
          print("Callbackkkkk $callback");

          Get.toNamed(RoutingNameConstants.HOME_SCREEN_ROUTE);
        } else {
          print("Callbacccc $callback");

          Get.toNamed(RoutingNameConstants.LOGIN_SCREEN_ROUTE);
        }
      },
    );
  }
}
