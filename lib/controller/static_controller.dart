import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ketitik/services/api_service.dart';

class StaticController extends GetxController {
  RxString dataString = "".obs;
  APIService apiService = APIService();

  @override
  void onInit() async {
    super.onInit();
    getUserData();
  }

  getUserData({pagename}) async {
    if (pagename == "terms") {
      dataString.value = (await apiService.getStaticTerms());
    } else {
      dataString.value = (await apiService.getStaticPrivacy());
    }

    print(" - ${dataString.value}");
  }
}
