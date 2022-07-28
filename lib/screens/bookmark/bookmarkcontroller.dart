import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ketitik/screens/bookmark/modelbookmark.dart';

import '../../services/api_service.dart';
import '../../utility/prefrence_service.dart';

class BookmarkController extends GetxController {
  RxString authToken = "".obs;
  RxList<BookMarkData> listBookmark = <BookMarkData>[].obs;
  RxList<String> listBookmarkStr = <String>[].obs;
  APIService apiService = APIService();
  final _prefrence = PrefrenceService();

  @override
  void onInit() async {
    super.onInit();
    //getUserData();
  }

  //getUserData() async {
  //  authToken.value = (await _prefrence.getToken().then((value) => value))!;
  //}

  Future<List<BookMarkData>> getDataBookMark(String deviceId) async {
    //getUserData();
    //ApplicationUtils.openDialog();
    print("deviceId ${deviceId}");
    listBookmark.value = await apiService.getBookmarkNews(deviceId);
    //ApplicationUtils.closeDialog();
    print(" - ${listBookmark.value}");

    return listBookmark.value;
  }

  fillStrData() {
    for (int i = 0; i < listBookmark.value.length; i++) {
      listBookmarkStr.add(listBookmark.value[i].id.toString());
    }
  }
}
