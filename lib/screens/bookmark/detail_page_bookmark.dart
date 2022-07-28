import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketitik/screens/bookmark/modelbookmark.dart';
import 'package:ketitik/utility/colorss.dart';

import '../homescreen/widgets/news_item.dart';

class BookmarkDetailPage extends StatefulWidget {
  final BookMarkData newsData;

  const BookmarkDetailPage(this.newsData);

  //const BookmarkDetailPage.b(this.titleTest);

  @override
  _BookmarkDetailPageState createState() => _BookmarkDetailPageState();
}

class _BookmarkDetailPageState extends State<BookmarkDetailPage> {
  //  late List NewsData newsData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: MyColors.themeColor,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          // margin: EdgeInsets.all(15),
          child: NewsItem(
            title: widget.newsData.title ?? "Notification TITLE",
            imageUrl: widget.newsData.image,
            description: widget.newsData.description ?? "  ",
            author: widget.newsData.author,
            source: widget.newsData.source,
            link: false,
          ),
        ));
  }
}
