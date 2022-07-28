import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ketitik/services/api_service.dart';

class NotificationControllerGet extends GetxController {
  APIService apiService = APIService();
  RxString title = "".obs,
      description = "".obs,
      image = "".obs,
      source = "".obs,
      uploads_type = "".obs,
      url = "".obs,
      category = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getData(String newsId) async {
    String stringRes = await apiService.getSpecificNewsData(newsId);

    var response = json.decode(stringRes);

    title.value = response["Data"]["title"];
    description.value = response["Data"]["description"];
    String imagess = response["Data"]["image"];
    if (imagess.startsWith("http")) {
      image.value = imagess;
    } else {
      image.value = APIService.BaseUrlAws + imagess;
    }
    uploads_type.value = response["Data"]["uploads_type"];
    source.value = response["Data"]["source"];
    url.value = response["Data"]["url"];
    category.value = response["Data"]["category"];
  }
}
//{"Success":true,"Message":"News Fetched Successfully",
// "Data":{"author":"Mentari","source":"Fimela",
// "url":"https:\/\/www.fimela.com\/beauty\/read\/4981344\/3-cara-mengeringkan-rambut-tanpa-hairdryer",
// "image":"http:\/\/13.233.68.171\/public\/News\/1654681936.JPG","country":"dl",
// "category":"Gaya Hidup",
// "description":"3 cara ini diketahui dapat membantu mengeringkan rambut basah tanpa bantuan hairdryer.
// Yang pertama, bagi rambut menjadi dua bagian kemudian peras dengan lembut.
// Kedua, Pilihlah handuk microfiber yang dapat maksimal menyerap air,
// kedia, usahakan keringkan bagian akar rambut terlebih dahulu.
// (Foto: unsplash.com\/norevision)"
// ,"id":2799,"title":"Gak Perlu Panik, Ini 3 Cara Keringkan Rambut Tanpa Hairdryer",
// "news_type":"everything",
// "trending":null,"uploads_type":"image"}}
