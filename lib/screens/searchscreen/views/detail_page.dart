import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketitik/utility/colorss.dart';

import '../../../models/newsdata.dart';

class DetailPage extends StatefulWidget {
  final DataArticle newsData;

  const DetailPage(this.newsData);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage.assetNetwork(
              height: 250,
              image: widget.newsData.image!,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/dummy_news.jpg',
                    fit: BoxFit.fitWidth);
              },
              placeholder: 'assets/images/dummy_news.jpg',
              // your assets image path
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0, top: 10, right: 10),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.newsData.title.toString(),
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.newsData.description.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
