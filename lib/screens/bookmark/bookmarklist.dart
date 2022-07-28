import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ketitik/screens/bookmark/bookmarkcontroller.dart';
import 'package:ketitik/screens/bookmark/detail_page_noti.dart';

import '../../utility/application_utils.dart';
import '../../utility/colorss.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  BookmarkController bookmarkController = BookmarkController();
  String deviceId = "";

  @override
  void initState() {
    super.initState();
    getDeviceData();
    //bookmarkController.getUserData();
    Timer(Duration(seconds: 1), () {
      bookmarkController.getDataBookMark(deviceId);
    });
  }

  getDeviceData() async {
    deviceId = await ApplicationUtils.getDeviceDetails();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;
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
                          itemCount: bookmarkController.listBookmark.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, i) {
                            return InkWell(
                                onTap: () {
                                  Get.to(NotificationDetailPage(
                                      bookmarkController.listBookmark[i].id
                                          .toString()));
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "${bookmarkController.listBookmark[i].title}",
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10.0,
                                                  top: 2.0,
                                                  bottom: 2.0),
                                              child: Text(
                                                "Source : ${bookmarkController.listBookmark[i].source}",
                                                maxLines: 2,
                                                softWrap: true,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            )),
                                        Divider()
                                      ],
                                    )));
                          }),
                    )
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
      child: Row(
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
            width: 95,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "My Bookmarks",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
