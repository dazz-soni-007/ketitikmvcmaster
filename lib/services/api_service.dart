import 'dart:async';
import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:ketitik/models/newsdata.dart';

import '../models/category.dart';
import '../models/ketitiknews.dart';
import '../models/privacymodel.dart';
import '../models/staticcontentmodel.dart';
import '../screens/bookmark/modelbookmark.dart';
import '../screens/prefrences/preferencemodel.dart';
import '../utility/application_utils.dart';
import '../utility/prefrence_service.dart';

class APIService {
  static final BaseUrlAws = "http://13.233.68.171/";
  final specificnews = "http://13.233.68.171/api/specific_news";
  final infographics = "http://13.233.68.171/api/infographics";
  final totalSwipesDevice = "http://13.233.68.171/api/swipe_count_devices";
  final uploadSwipe = "http://13.233.68.171/api/categoryWiseSwipes";
  final getBookmarkUrl = "http://13.233.68.171/api/getBookmarks";
  final addBookmarkUrl = "http://13.233.68.171/api/addBookmark";
  final getPreferences = "http://13.233.68.171/api/getPrefrences";
  final terms = "http://13.233.68.171/api/terms_condition";
  final token_update = "http://13.233.68.171/api/add_update_token";
  final privacy = "http://13.233.68.171/api/privacy";
  final allnewsurl = "http://13.233.68.171/api/allnews_list";
  final allnewsurls = Uri.parse("http://13.233.68.171/api/allnews_list");
  final newsprefrence = Uri.parse("http://13.233.68.171/api/preferencesData");
  final searchUrl = Uri.parse("http://13.233.68.171/api/search");
  final updateProfile = "http://13.233.68.171/api/update_profile";
  static final register = "http://13.233.68.171/api/socialregister";
  static final login = "http://13.233.68.171/api/sociallogin";

//http://83.136.219.147/News/public

  String userToken = "";
  PrefrenceService prefrenceService = PrefrenceService();

  Future<String> getSpecificNewsData(String newsId) async {
    try {
      var response = await http.post(Uri.parse(specificnews),
          body: {"id": newsId}).catchError((err) {
        print('Error : $err');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Specific News :: Success ${response.body.toString()}");
        return response.body.toString();
      } else {
        print("Specific News :: Failed ${response.body.toString()}");
        return "";
      }
    } catch (e) {
      print("Specific News :: Error ${e.toString()}");
      return "";
    }
  }

  Future<String> getInfoGraphic() async {
    try {
      var response =
          await http.post(Uri.parse(infographics), body: {}).catchError((err) {
        print('Error : $err');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("InfoGraphic Content :: Success ${response.body.toString()}");
        return response.body.toString();
      } else {
        print("InfoGraphic Content :: Failed ${response.body.toString()}");
        return "";
      }
    } catch (e) {
      print("InfoGraphic Content :: Error ${e.toString()}");
      return "";
    }
  }

  Future<String> updateSwipeDevice(String deviceId, String news_id) async {
    print('Swipe API  : $deviceId :: $news_id');
    try {
      var response = await http.post(Uri.parse(totalSwipesDevice),
          body: {"device_id": deviceId, "news_id": news_id}).catchError((err) {
        print('Error : $err');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Total News Swipe :: Success ${response.body.toString()}");
        return response.body.toString();
      } else {
        print("Total News Swipe :: Failed ${response.body.toString()}");
        return "";
      }
    } catch (e) {
      print("Total News Swipe :: Error ${e.toString()}");
      return "";
    }
  }

  Future<String> updateSwipeCategory(String categoryName) async {
    try {
      var response = await http.post(Uri.parse(uploadSwipe), body: {
        "category": categoryName,
      }).catchError((err) {
        print('Error : $err');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Category News Update :: Success ${response.body.toString()}");
        return response.body.toString();
      } else {
        print("Category News Update :: Failed ${response.body.toString()}");
        return "";
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return "";
    }
  }

  Future<String> updateToken(String devide_id, String device_token) async {
    try {
      print('Token Params : $device_token ---- $devide_id');
      var response = await http.post(Uri.parse(token_update), body: {
        "device_id": devide_id,
        "device_token": device_token,
        "device_type": "apple"
      }).catchError((err) {
        print('Error : $err');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Token update Success ${response.body.toString()}");
        return response.body.toString();
      } else {
        print("Token update failed ${response.body.toString()}");
        return "";
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return "";
    }
  }

  Future<String> updateUserProfile(
      String name, String email, String phone, String authtoken) async {
    try {
      var response = await http.post(Uri.parse(updateProfile), headers: {
        "token": authtoken
      }, body: {
        "email_id": email,
        "name": name,
        "contact": phone
      }).catchError((err) {
        print('Error : $err');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("profile update ${response.body.toString()}");

        return response.body.toString();
      } else {
        print("profile update failed ${response.body.toString()}");
        return "";
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return "";
    }
  }

  Future<List<BookMarkData>> getBookmarkNews(String deviceId) async {
    try {
      var response = await http.post(Uri.parse(getBookmarkUrl),
          headers: {}, body: {"device_id": deviceId}).catchError((err) {
        print('Bookmark Error : $err');
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Bookmark news : ${response.body}");
        final news = bookMarkDataFromJson(response.body);

        return news.data;
      } else {
        print("Bookmark news : 0 Data");
        return [];
      }
    } catch (e) {
      print("Bookmark Error ${e.toString()}");
      return [];
    }
  }

  Future<List<KetitikModel>?> getAllArticles(
      {required String filter, String? pageNumber, String? deviceId}) async {
    try {
      bool statusLogin = await prefrenceService.getLoggedIn();
      bool statusInternet = await ApplicationUtils.isOnline();

      if (statusInternet) {
        print("loginStatus---->$statusLogin");

        var response = await http.post(allnewsurls, headers: {}, body: {
          "device_id": deviceId,
          "page": pageNumber.toString(),
          "filter": filter
        }).catchError((err) async {
          print('newsdata  : $err');
        });

        print("URl hit");
        print("response ${response.body.toString()}");
        print("response ${response.statusCode.toString()}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          APICacheDBModel cacheDBModel =
              APICacheDBModel(key: "API_Categories", syncData: response.body);
          await APICacheManager().addCacheData(cacheDBModel);
          final news = keTitikNewsFromJson(response.body);

          return news.data;
        } else {
          print("newsdataelse : ");
          return [];
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("API_Categories");
        print("chace hit");
        final news = keTitikNewsFromJson(cacheData.syncData);

        return news.data;
      }
    } catch (e) {
      print("Error ${e.toString()}");

      return [];
    }
  }

  //cached top Stories data
  Future<List<KetitikModel>?> getTopArticles(
      {required String filter, String? pageNumber, String? deviceId}) async {
    try {
      print("pageNumber---->$pageNumber");
      bool statusInternet = await ApplicationUtils.isOnline();
      if (statusInternet) {
        var response = null;
        String tokenAuth = await prefrenceService.getAuthToken();
        print("authToken Top --->$tokenAuth");
        response = await http.post(allnewsurls, headers: {}, body: {
          "device_id": deviceId,
          "page": pageNumber.toString(),
          "filter": filter
        }).catchError((err) async {
          print('newsdata  : $err');
        });

        print("URl hit $allnewsurls");
        print(" top stories ${response.body.toString()}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          print(response.body.toString());
          final news = keTitikNewsFromJson(response.body);

          APICacheDBModel cacheDBModel =
              APICacheDBModel(key: "Top_Stories", syncData: response.body);
          await APICacheManager().addCacheData(cacheDBModel);

          return news.data;
        } else {
          print("newsdata else : ");
          return [];
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("Top_Stories");
        print("chace hit");
        final news = keTitikNewsFromJson(cacheData.syncData);

        return news.data;
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return [];
    }
  }

  //cached trending data
  Future<List<KetitikModel>?> gettrendingArticles(
      {required String filter, String? pageNumber, String? deviceId}) async {
    try {
      print("pageNumber---->$pageNumber");

      bool statusInternet = await ApplicationUtils.isOnline();
      if (statusInternet) {
        var response = null;
        response = await http.post(allnewsurls, headers: {}, body: {
          "device_id": deviceId,
          "page": pageNumber.toString(),
          "filter": filter
        }).catchError((err) async {
          print('newsdata  : $err');
        });
        print("URl hit");
        if (response.statusCode == 200 || response.statusCode == 201) {
          APICacheDBModel cacheDBModel =
              APICacheDBModel(key: "Trending_Stories", syncData: response.body);
          await APICacheManager().addCacheData(cacheDBModel);
          final news = keTitikNewsFromJson(response.body);

          return news.data;
        } else {
          print("newsdataelse : ");
          return [];
        }
      } else {
        var cacheData =
            await APICacheManager().getCacheData("Trending_Stories");
        print("chace hit");
        final news = keTitikNewsFromJson(cacheData.syncData);

        return news.data;
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return [];
    }
  }

  Future<List<KetitikModel>?> getFeedArticles(
      {required String filter, String? pageNumber, String? deviceId}) async {
    try {
      print("pageNumber---->$pageNumber");

      bool statusInternet = await ApplicationUtils.isOnline();
      if (statusInternet) {
        var response = await http.post(allnewsurls, headers: {}, body: {
          "page": pageNumber.toString(),
          "device_id": deviceId,
          "filter": filter
        }).catchError((err) async {
          print('newsdata  : $err');
        });

        print("pageNumber---->${response.body}");
        print("URl hit");
        if (response.statusCode == 200 || response.statusCode == 201) {
          APICacheDBModel cacheDBModel =
              APICacheDBModel(key: "Feed_Stories", syncData: response.body);
          await APICacheManager().addCacheData(cacheDBModel);

          final news = keTitikNewsFromJson(response.body);
          return news.data;
        } else {
          print("newsdataelse : ");
          return [];
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("Feed_Stories");
        print("Cache Hit");
        final news = keTitikNewsFromJson(cacheData.syncData);

        return news.data;
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return [];
    }
  }

  Future<String> getStaticPrivacy() async {
    try {
      var response = await http.post(Uri.parse(privacy)).catchError((err) {
        print('Error : $err');
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final news = staticPrivacyFromJson(response.body);
        print("Search news : ${news.data[0].privacy}");
        return news.data[0].privacy;
      } else {
        return "";
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return "";
    }
  }

  Future<String> getStaticTerms() async {
    try {
      var response = await http.post(Uri.parse(terms)).catchError((err) {
        print('Error : $err');
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final news = staticContentFromJson(response.body);
        print("Search news : ${news.data[0].terms}");
        return news.data[0].terms;
      } else {
        return "";
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return "";
    }
  }

  Future<List<DataArticle>?> searchNews(String query) async {
    try {
      var response =
          await http.post(searchUrl, body: {"key": query}).catchError((err) {
        print('Error : $err');
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final news = newsDataFromJson(response.body);
        print("Search news : ${news.data}");
        return news.data;
      } else {
        return [];
      }
    } catch (e) {
      print("Error ${e.toString()}");
      return [];
    }
  }

  String getCurrentDate() {
    DateTime dateToday = new DateTime.now();
    String date = dateToday.toString().substring(0, 10);

    print(date);
    return date; // 2021-06-24
  }

  getUserToken() {
    prefrenceService.getToken().then((value) => {userToken = value!});
    print("token : $userToken");
  }

  Future<List<CategoryName>> getMyPreference(String token) async {
    final url = Uri.parse(getPreferences);

    try {
      var response = await http.post(
        url,
        body: {"device_id": token},
      ).catchError((err) {
        print('Error : $err');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final category = preferenceFromJson(response.body);
        print("News : ${category.data}");
        return category.data.categoryName;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> deleteUser(String device_id) async {
    final url = Uri.parse(BaseUrlAws + "api/delete_user");

    try {
      var response = await http
          .post(url, body: {"device_id": device_id}).catchError((err) {
        print('Error : $err');
      });
      if (response.statusCode == 200 || response.statusCode == 201) {

        Map<String, dynamic> data = jsonDecode(response.body);

        print("Search news : ${data.toString()}");
        if (data['status'] == true) {
          return "User SuccessFully Deleted";
        } else {
          return "";
        }
      } else {
        return "Something Went Wrong Please try again";
      }
    } catch (e) {
      return "Something Went Wrong Please try again";
    }
  }

  Future<List<Preference>> getCategory() async {
    final url = Uri.parse('https://13.233.68.171/api/getAllCategory');

    try {
      var response = await http.get(url).catchError((err) {
        print('Error : $err');
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Res Pref : ${response.body}');
        final category = categoryDataFromJson(response.body);
        return category.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  saveUserPrefrence(String category, String deviceId) async {
    final url = Uri.parse('http://13.233.68.171/api/userPreferences');

    Map<String, dynamic> mapData = {
      "category": category,
      "country": "[dl]",
      "device_id": deviceId,
    };

    print("save preferenceData $category --- $deviceId ---- [dl]");

    try {
      var response = await http.post(url, headers: {}, body: mapData);

      if (response.statusCode == 200) {
        var reponseData = json.decode(response.body);
        print('reponseData : $reponseData');
        return reponseData;
      } else {
        var reponseData = json.decode(response.body);
        print('reponseData : $reponseData');
        return reponseData;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addBookmark(
      String? urlsss, String? news_id, String? title) async {
    String deviceId = await ApplicationUtils.getDeviceDetails();
    String responseStr = "";
    final url = Uri.parse(addBookmarkUrl);

    print('request Add Bookmark : $news_id --- $title ---- $deviceId');
    Map<String, dynamic> mapData = {
      "url": urlsss,
      "device_id": deviceId,
      "news_id": news_id,
      "title": title,
    };

    print('response Add Bookmark : $mapData');

    try {
      var response = await http.post(url, headers: {}, body: mapData);
      print('response Add Bookmark : ${response.body.toString()}');

      if (response.statusCode == 200) {
        responseStr = response.body;
        print('response Add Bookmark : $responseStr');
      }
    } catch (e) {
      print('response Add Bookmark : ${e.toString()}');
      return e.toString();
    }
    return responseStr;
  }
}
