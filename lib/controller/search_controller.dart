import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:ketitik/models/newsdata.dart';
import 'package:ketitik/services/api_service.dart';

class SearchController extends GetxController {
  RxList<DataArticle> searchResult = <DataArticle>[].obs;

  APIService apiService = APIService();

  @override
  void onInit() async {
    super.onInit();
    getSearchNews();
  }

  Future<List<DataArticle>?> getSearchNews({String? query}) async {
    try {
      var response = await http.post(apiService.searchUrl,
          body: {"key": query}).catchError((err) {});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final news = newsDataFromJson(response.body);
        searchResult.value = newsDataFromJson(response.body).data;
        update();
        //return news.data;
        print(
            "Total Data found for ${query.toString()} is ${searchResult.length} :: ${news.toString()}");
      } else {
        searchResult.value.clear();
        update();
        print("No Data for ${query.toString()}");
      }
    } catch (e) {
      searchResult.value.clear();
      update();
      print("Error ${e.toString()}");
    }
  }
}
