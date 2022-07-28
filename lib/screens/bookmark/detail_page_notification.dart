import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketitik/controller/notificationdetailcontroller.dart';
import 'package:ketitik/services/api_service.dart';
import 'package:ketitik/utility/colorss.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../utility/NewsItemShare.dart';
import '../../utility/application_utils.dart';
import '../../utility/customicons_icons.dart';
import '../../utility/swipeaction.dart';
import '../homescreen/view/home_screen.dart';
import '../homescreen/widgets/news_item_large.dart';
import '../homescreen/widgets/news_item_video.dart';

class NotiDetailPage extends StatefulWidget {
  final String newsData;

  const NotiDetailPage(this.newsData);

  @override
  _BookmarkDetailPageState createState() => _BookmarkDetailPageState();
}

class _BookmarkDetailPageState extends State<NotiDetailPage>
    with WidgetsBindingObserver {
  APIService apiService = APIService();
  bool statusBookmark = false;
  bool isLiked = false;
  String isInnerClick = "false";
  String stringRes = "";
  String title = "",
      description = "",
      image = "",
      source = "",
      uploads_type = "";
  ScreenshotController screenshotController = ScreenshotController();
  NotificationControllerGet controllerGet = NotificationControllerGet();
  late AppLifecycleState _notification_status;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    print("News Selected Id :: ${widget.newsData}");
    controllerGet.getData(widget.newsData);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    /* setState(() {
      _notification_status = state;
    });*/
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        print("Status :: $isInnerClick");
        if (isInnerClick == "true") {
        } else {
          Get.to(MyHomePage());
          //Get.back();
        }
        isInnerClick = "false";
        print("Status :: $isInnerClick");
        break;
      /*  case AppLifecycleState.resumed:
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending');
        break;*/
    }
  }

  fullShareView() {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Colors.white,
        )),
        NewsItemShare(
            title: controllerGet.title.value,
            imageUrl: controllerGet.image.value,
            description: controllerGet.description.value ?? "  ",
            author: "controllerGetauthor",
            source: controllerGet.source.value),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/appplaystore.png",
                        height: 80,
                        width: 150,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/ketwhitezoom.png",
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  getTopBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(100), // Set this height
        child: Container(
            child: Container(
          decoration: BoxDecoration(
            color: MyColors.themeColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            border: Border.all(
              width: 2,
              color: MyColors.themeColor,
              style: BorderStyle.solid,
            ),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              InkWell(
                onTap: () => {Get.to(MyHomePage()), print("Tap Tap")},
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/backbutton.png',
                      width: 25,
                      height: 25,
                      color: Colors.black,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 110.0),
                child: Image.asset(
                  "assets/images/ketsquarezoom.png",
                  width: 70,
                  height: 70,
                ),
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: getTopBar(),
          body: Obx(() => Stack(children: [
                Positioned.fill(
                    top: 150,
                    child: Container(
                      color: Colors.white,
                    )),
                controllerGet.uploads_type.value == "video"
                    ? NewsItemVideoss(
                        title: controllerGet.title.value,
                        imageUrl: controllerGet.image.value,
                        description: controllerGet.description.value,
                        author: "",
                        source: controllerGet.source.value,
                        link: false,
                      )
                    : NewsItemLarge(
                        title: controllerGet.title.value,
                        imageUrl: controllerGet.image.value,
                        description: controllerGet.description.value,
                        author: "",
                        source: controllerGet.source.value,
                        link: false,
                      ),
                Positioned(
                  left: 5,
                  bottom: 50,
                  child: GestureDetector(
                    onTap: () {
                      if (isLiked == true) {
                        isLiked = false;
                      } else {
                        isLiked = true;
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                        10,
                      )),
                      child: Center(
                          child: isLiked
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: MyColors.themeBlackTrans,
                                  size: 25,
                                )),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Align(
                      //alignment: FractionalOffset.bottomCenter,
                      child: GestureDetector(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // getUserToken();
                                if (statusBookmark == true) {
                                  statusBookmark = false;
                                } else {
                                  apiService.addBookmark(
                                    controllerGet.url.value,
                                    widget.newsData,
                                    controllerGet.title.value,
                                  );
                                  statusBookmark = true;
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                  10,
                                )),
                                child: Center(
                                  child: statusBookmark
                                      ? Icon(
                                          Icons.bookmark,
                                          color: Colors.black,
                                          size: 25,
                                        )
                                      : Icon(
                                          Icons.bookmark_border,
                                          color: MyColors.themeBlackTrans,
                                          size: 25,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            GestureDetector(
                              onTap: () async {
                                isInnerClick = "true";
                                print("Status :: $isInnerClick");
                                ApplicationUtils.openDialog();
                                final imageFile = await screenshotController
                                    .captureFromWidget(Container(
                                        color: Colors.white,
                                        child: fullShareView()));

                                ApplicationUtils.closeDialog();

                                if (imageFile != null) {
                                  final directory =
                                      await getApplicationDocumentsDirectory();
                                  final imagePath =
                                      await File('${directory.path}/image.png')
                                          .create();
                                  await imagePath.writeAsBytes(imageFile);

                                  /// Share Plugin
                                  await Share.shareFiles([imagePath.path],
                                      text:
                                          "Download keTitik, aplikasi berita Indonesia. Hemat waktu membaca berita dalam 60 kata \n Google Play : https://play.google.com/store/apps/details?id=com.app.ketitik.ketitik",
                                      subject:
                                          "Download keTitik, aplikasi berita Indonesia. Hemat waktu membaca berita dalam 60 kata \n Google Play : https://play.google.com/store/apps/details?id=com.app.ketitik.ketitik");
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                  10,
                                )),
                                child: Center(
                                  child: Icon(
                                    Customicons.share_1,
                                    color: MyColors.themeBlackTrans,
                                    size: 23,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(FullPageRoute(
                            controllerGet.category.value,
                            controllerGet.url.value,
                            widget.newsData));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                controllerGet.image.value,
                              ),
                              scale: 50,
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.cover),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          height: 50,
                          color: MyColors.whiteTransTrans,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: getBottomText(
                                  controllerGet.title.value.toString(), 50)),
                        ),
                      )),
                ),
              ]))),
    );
  }
}

getBottomText(String myText, int length) {
  return Text.rich(TextSpan(
    children: <InlineSpan>[
      TextSpan(
          text: myText.length > length
              ? myText.substring(0, length) + "..."
              : "$myText",
          style: const TextStyle(
            fontSize: 12,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.normal,
            color: Colors.white,
          )),
      WidgetSpan(
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: const [
              SizedBox(
                height: 5,
              ),
              Text(
                'Read More',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )
    ],
  ));
}
