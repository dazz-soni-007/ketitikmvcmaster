import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ketitik/utility/application_utils.dart';

import '../utility/prefrence_service.dart';

class ProfileController extends GetxController {
  RxString name = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString authToken = "".obs;
  RxString avatarPos = "assets/images/menavatarnew.png".obs;
  RxInt avatarIndex = 0.obs;
  Rx<bool> isLoggedIn = false.obs;
  final _prefrence = PrefrenceService();

  @override
  void onInit() async {
    super.onInit();
    getUserData();
  }

  getUserData() async {
    name.value = (await _prefrence.getName())!;
    email.value = (await _prefrence.getEmail())!;
    //phone.value = (await _prefrence.getPhone())!;
    authToken.value = (await _prefrence.getToken())!;
    isLoggedIn.value = await _prefrence.getLoggedIn();
    String? pathIndex = await _prefrence.getAvatarImage();
    avatarIndex.value = int.parse(pathIndex.toString());

    avatarPos.value =
        ApplicationUtils.getAvatarImage(avatarIndex.value.toString());

    update();
  }
}
