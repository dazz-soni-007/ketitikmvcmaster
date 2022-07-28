import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketitik/controller/search_controller.dart';
import 'package:ketitik/models/newsdata.dart';
import 'package:ketitik/screens/bookmark/detail_page_noti.dart';
import 'package:ketitik/services/api_service.dart';
import 'package:ketitik/utility/application_utils.dart';
import 'package:ketitik/utility/colorss.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<DataArticle> articles = List<DataArticle>.empty(growable: true);
  late List<DataArticle> seachResult = List<DataArticle>.empty(growable: true);
  SearchController getSearchController = SearchController();
  late TextEditingController searchController = TextEditingController();

  APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
  }

  getCacheImage(String imageUrls) {
    return CachedNetworkImage(
      imageUrl: imageUrls,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        height: 250,
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: searchWidget(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Obx(
                      () => ListView.builder(
                          itemCount: getSearchController.searchResult.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, i) {
                            return InkWell(
                              onTap: () {
                                Get.to(NotificationDetailPage(
                                    getSearchController.searchResult[i].id
                                        .toString()));
                              },
                              child: searchNewsItem(
                                  getSearchController.searchResult[i]),
                            );
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget searchWidget() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              MyColors.themeColor,
              MyColors.themeColor,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0]),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        border: Border.all(
          width: 1,
          color: MyColors.themeColor,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/left.png",
                width: 25,
                height: 25,
              ),
            ),
            onTap: () => {Navigator.pop(context)},
          ),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Find Your News",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Search anything here",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              controller: searchController,
              key: Key("userName"),
              keyboardType: TextInputType.text,
              style: const TextStyle(
                  color: Color(0xff8E8E91),
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400),
              cursorColor: MyColors.themeColorYellow,
              // onChanged: onSearchTextChanged,
              decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/searchbar.png',
                      color: Colors.grey,
                      width: 25,
                    ),
                  ),
                  hintText: "Search news here",
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 13,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white38,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white38,
                    ),
                  )),
              onSubmitted: (value) => onSearchTextChanged(value),
              //onChanged: (value) => onSearchTextChanged(value),
            ),
          ),
        ],
      ),
    );
  }

  searchNewsItem(DataArticle dataArticle) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            padding: const EdgeInsets.all(0),
            height: 250,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: getCacheImage(dataArticle.image! ??
                        "http://placeimg.com/640/480/any")),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        MyColors.themeBlackTrans,
                        MyColors.themeBlackTrans,
                        MyColors.themeBlackTrans,
                      ],
                      begin: const FractionalOffset(1.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                    )),
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataArticle.title! ?? "---",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          dataArticle.source! ?? "---",
                          style: TextStyle(
                            color: MyColors.themeColor,
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  onSearchTextChanged(String value) async {
    ApplicationUtils.openDialog();
    print("Search Query :: $value");
    getSearchController.getSearchNews(query: value);
    ApplicationUtils.closeDialog();
  }
}
