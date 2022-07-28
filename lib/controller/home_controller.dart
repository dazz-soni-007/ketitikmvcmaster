import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:ketitik/models/ketitiknews.dart';
import 'package:ketitik/services/api_service.dart';
import 'package:ketitik/utility/application_utils.dart';

import '../utility/prefrence_service.dart';

class HomeController extends GetxController {
  RxBool isVisible = false.obs;
  RxInt pageNumber = 1.obs;
  RxList<KetitikModel> list = <KetitikModel>[].obs;
  APIService _apiService = APIService();
  RxString filter = "allNews".obs;
  RxInt indexCurrent = 0.obs;
  RxInt bookmarkStatus = 0.obs;
  PrefrenceService prefrenceService = PrefrenceService();
  RxBool isLoggedin = false.obs;
  RxString userToken = "".obs;
  String deviceId = "";
  String firebaseToken = "";
  RxBool isLiked = false.obs;
  RxBool isTutorialsShow = true.obs;
  var multiple_images;
  var uploads_type;
  var type;
  var image;

  onTapVisibilty() {
    if (isVisible.value == true) {
      isVisible.value = false;
    } else {
      isVisible.value = true;
    }
  }

  onCrossClickCross() {
    if (isTutorialsShow.value == true) {
      isTutorialsShow.value = false;
    } else {
      isTutorialsShow.value = true;
    }
  }

  updateValueList(int index) {
    var count = list.value[index].bookmarks;
    print("object $count");
    bookmarkStatus.value = count == 0 ? 1 : 0;
    list.value[index].bookmarks = count == 0 ? 1 : 0;
    print("object ${list.value[index].bookmarks}");
  }

  getLoggedinStatus() {
    prefrenceService.getLoggedIn().then((value) => {isLoggedin.value = value});
  }

  refreshToTop() {
    pageNumber = 1.obs;
    indexCurrent = 0.obs;
  }

  resetData() {
    list.value.clear();
    pageNumber = 1.obs;
    indexCurrent = 0.obs;
  }

  getTheInfographicData() async {
    var response = await _apiService.getInfoGraphic();
    var data = json.decode(response);
    var success = data["Success"];

    print("$success");

    if (success == true) {
      var dataRes = data["Data"];
      //{"Success":false,"Message":"Record not found","Data":""}
      multiple_images = dataRes["multiple_images"];
      uploads_type = dataRes["uploads_type"];
      type = dataRes["type"];
      image = dataRes["image"];
    } else {
      multiple_images = "abc";
      uploads_type = "abc";
      type = "abc";
      image = "abc";
    }
  }

  Future<List<KetitikModel>> getMyFeedData() async {
    resetData();
    getDeviceData();

    list.value = (await _apiService.getFeedArticles(
        filter: "feeds",
        pageNumber: pageNumber.value.toString(),
        deviceId: deviceId))!;
    //pageNumber.value = pageNumber.value + 1;

    return list.value;
  }

  Future<List<KetitikModel>> getTopStoriesData() async {
    resetData();
    getDeviceData();

    list.value = (await _apiService.getTopArticles(
        filter: "top",
        pageNumber: pageNumber.value.toString(),
        deviceId: deviceId))!;

    //pageNumber.value = pageNumber.value + 1;

    print("ListData Top $pageNumber ${list.value.length}");

    return list.value;
  }

  List<KetitikModel> shuffle(List<KetitikModel> items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  Future<List<KetitikModel>> getTrendingData() async {
    resetData();
    getDeviceData();
    list.value = (await _apiService.gettrendingArticles(
        filter: "trending",
        pageNumber: pageNumber.value.toString(),
        deviceId: deviceId))!;

    // pageNumber.value = pageNumber.value + 1;

    print("ListData Trending $pageNumber ${list.value.length}");

    return list.value;
  }

  Future<List<KetitikModel>> getUpdatedList() async {
    //List<KetitikModel> newsUpdated = shuffle(list.value);
    return list.value;
  }

  Future<List<KetitikModel>> getAllNewsData() async {
    resetData();
    getDeviceData();

    Timer(Duration(seconds: 1), () async {
      list.value = (await _apiService.getAllArticles(
          filter: "allNews",
          pageNumber: pageNumber.value.toString(),
          deviceId: deviceId))!;

      // pageNumber.value = pageNumber.value + 1;
      print("Device Id :: $deviceId");
      print("ListData All deviceToken $deviceId");
    });

    return list.value;
  }

  getMoreData(int indexCurrentt) async {
    indexCurrent.value = indexCurrentt;
    List<KetitikModel> moreList = <KetitikModel>[];

    pageNumber.value = pageNumber.value + 1;

    print("ListData Pagination Index ${pageNumber.value.toString()}");
    moreList = (await _apiService.getAllArticles(
        filter: filter.value,
        pageNumber: pageNumber.value.toString(),
        deviceId: deviceId))!;
    print("ListData More $pageNumber ${moreList.length}");

    if (moreList.isEmpty) {
    } else {
      //pageNumber.value = pageNumber.value + 1;
      list.addAll(moreList);
      print("ListData More $pageNumber ${moreList.length}");
    }
  }

  getDeviceData() async {
    deviceId = await ApplicationUtils.getDeviceDetails();
    firebaseToken = await getPlatformSpecificToken();
    _apiService.updateToken(deviceId, firebaseToken);
    print("---- device $deviceId");
  }

  Future<String> getDeviceIDs() async {
    deviceId = await ApplicationUtils.getDeviceDetails();
    return deviceId;
  }

  Future<String> getToken() async {
    String token = (await FirebaseMessaging.instance.getToken())!;
    print("firebase token : $token");
    return token;
  }

  Future<String> getPlatformSpecificToken() async {
    String token = "";
    if (Platform.isAndroid) {
      token = (await FirebaseMessaging.instance.getToken())!;
      print("firebase token : $token");
    } else if (Platform.isIOS) {
      token = (await FirebaseMessaging.instance.getAPNSToken())!;
    }
    return token;
  }

  @override
  void onInit() {
    super.onInit();
    getDeviceData();
    onTapVisibilty();
    getAllNewsData();
  }
}
