// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ketitik/models/ketitiknews.dart';
import 'package:ketitik/screens/bookmark/bookmarkcontroller.dart';
import 'package:ketitik/screens/bookmark/detail_page_notification.dart';
import 'package:ketitik/screens/searchscreen/views/search_page.dart';
import 'package:ketitik/services/api_service.dart';
import 'package:ketitik/utility/NewsItemShare.dart';
import 'package:ketitik/utility/application_utils.dart';
import 'package:ketitik/utility/pushNotification.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_share/social_share.dart';

import '../../../controller/home_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../utility/colorss.dart';
import '../../../utility/customicons_icons.dart';
import '../../../utility/prefrence_service.dart';
import '../../../utility/swipeaction.dart';
import '../../bookmark/detail_page_noti.dart';
import '../../profile/profilescreen.dart';
import '../../staticpages/tutorialpage.dart';
import '../widgets/news_item.dart';
import '../widgets/news_item_video.dart';
import '../widgets/newsimage_item.dart';
import '../widgets/newsimages_item.dart';
import '../widgets/newsvideo_item.dart';

class MyHomePage extends StatefulWidget {
  String? foo = "abc";

  MyHomePage({Key? key, this.foo}) : super(key: key);

  MyHomePage.withA({Key? key, this.foo});

  MyHomePage.withNotification({Key? key, this.foo});

  @override
  State<MyHomePage> createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  PushNotificationService pushNotificationService = PushNotificationService();
  int selectedIndex = 0;

  ProfileController profileController = ProfileController();
  PrefrenceService prefrenceService = PrefrenceService();
  ScreenshotController screenshotController = ScreenshotController();

  final APIService _apiService = APIService();
  final HomeController homeController = Get.put(HomeController());
  final BookmarkController bookmarkController = Get.put(BookmarkController());

  var articleFull = "";
  var categoryNameFull = "";
  var articleTitle = "";
  var newsId = "";
  var articleCurrent;
  var page_number = 1;

  String userToken = "";
  bool statusLoggin = false;

  // final FlutterShareMe flutterShareMe = FlutterShareMe();
  String deviceId = "";
  bool isFirstTime = true;
  String activeTab = "";

  //notification

  //PushNotificationService pushNotificationService = PushNotificationService();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  @override
  void initState() {
    getDeviceIdData();
    WidgetsBinding.instance.addObserver(this);
    var iOS = IOSInitializationSettings();
    var android = const AndroidInitializationSettings('@mipmap/ic_ketitiknew');
    var initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);

    launchDetails(context);

    homeController.getDeviceData();
    homeController.getTheInfographicData();
    homeController.getLoggedinStatus();
    //homeController.getAllNewsData();

    getUserTutorial();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        break;
      case AppLifecycleState.inactive:
        getTabData(selectedIndex);
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        // widget is paused
        break;
      case AppLifecycleState.detached:
        // widget is detached
        break;
    }
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void onSelectNotification(String? payload) {
    print("Normal Call :: Notification");
    Get.to(NotificationDetailPage(payload.toString()));
  }

  launchDetails(BuildContext context) async {
    final notificationOnLaunchDetails = await FlutterLocalNotificationsPlugin()
        .getNotificationAppLaunchDetails();
    if (notificationOnLaunchDetails?.didNotificationLaunchApp ?? false) {
      onSelectNotification(notificationOnLaunchDetails!.payload);
    }
  }

  navigateToNotification() {
    // Future.delayed(Duration.zero, () {
    Get.to(NotiDetailPage(widget.foo.toString()));
    // });
  }

  getUserTutorial() {
    prefrenceService
        .getTutorialStatus()
        .then((value) => {isFirstTime = value, hideTutorial()});
    print("Tutorial Status :: $isFirstTime");
  }

  saveTutorial() {
    prefrenceService.setTutorialStatus(true);
    print("Tutorial Status  :: $isFirstTime");
  }

  getDeviceIdData() async {
    deviceId = await homeController.getDeviceIDs();

    String deviceIdController = homeController.deviceId;
    print("device Id Controller :: $deviceIdController");
    print("device Id Home :: $deviceId");
  }

  getUserToken() {
    prefrenceService.getToken().then((value) => {userToken = value!});
    print("token : $userToken");
  }

  @override
  Widget build(BuildContext context) {
    pushNotificationService.initialise(context);
    double widthscreen = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  //toolbar
                  Visibility(
                      visible: homeController.isVisible.value,
                      child: topBar(widthscreen)),
                  Obx(
                    () => FutureBuilder<List<KetitikModel>?>(
                      future: homeController.getUpdatedList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.74,
                            child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      MyColors.themeColor),
                                )),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            snapshot.data?.length == 0) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.74,
                            child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      MyColors.themeColor),
                                )),
                          );
                        } else {
                          List<KetitikModel>? listOfArticle = snapshot.data;
                          var height = homeController.isVisible.value
                              ? MediaQuery.of(context).size.height * 0.74
                              : MediaQuery.of(context).size.height;

                          return GestureDetector(
                              onHorizontalDragEnd: (DragEndDetails details) {
                                if (details.primaryVelocity! > 0) {
                                  // User swiped Left
                                  Navigator.of(context)
                                      .push(ProfilePageRoute());
                                } else if (details.primaryVelocity! < 0) {
                                  // User swiped Right
                                  Navigator.of(context).push(FullPageRoute(
                                      categoryNameFull, articleFull, newsId));
                                }
                              },
                              child: CarouselSlider.builder(
                                  carouselController: CarouselController(),
                                  options: CarouselOptions(
                                    scrollDirection: Axis.vertical,
                                    height: height,
                                    enableInfiniteScroll: true,
                                    initialPage:
                                        homeController.indexCurrent.value,
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) {
                                      print(
                                          "device id for NewsSwipe :: $deviceId");
                                      KetitikModel model =
                                          listOfArticle![index];
                                      _apiService.updateSwipeDevice(
                                          deviceId, model.id.toString());
                                    },
                                  ),
                                  itemCount: listOfArticle?.length,
                                  itemBuilder: (BuildContext context,
                                      int itemIndex, int pageViewIndex) {
                                    int? lengthCurrent = listOfArticle?.length;
                                    print("ListData $lengthCurrent");
                                    print("ListIndex $itemIndex");
                                    var article = listOfArticle![itemIndex];
                                    homeController.bookmarkStatus.value =
                                        article.bookmarks!;

                                    categoryNameFull = article.category!;
                                    articleFull = article.url!;
                                    articleTitle = article.title!;
                                    newsId = article.id.toString();

                                    if (itemIndex == lengthCurrent! - 2) {
                                      homeController.getMoreData(itemIndex);
                                    }
                                    if ((itemIndex + 1) % 3 == 0) {
                                      homeController.getTheInfographicData();
                                    }
                                    if (itemIndex == 0) {
                                      KetitikModel model =
                                          listOfArticle[itemIndex];
                                      _apiService.updateSwipeDevice(
                                          deviceId, model.id.toString());
                                    }

                                    return (itemIndex + 1) % 5 == 0
                                        ? homeController.uploads_type == "abc"
                                            ? fullCourosolView(
                                                article, itemIndex)
                                            : getDataInfo()
                                        : fullCourosolView(article, itemIndex);
                                  }));
                        }
                      },
                    ),
                  )
                  //main view
                ],
              ),
            ),
            Visibility(
                visible: isFirstTime,
                child: GestureDetector(
                    onTap: () => {hideTutorial()}, child: TutorialPages())),
            /* Visibility(
                visible: widget.foo == null ? false : true,
                child: NotiDetailPage(widget.foo.toString()))*/
          ],
        )));
  }

  hideTutorial() {
    if (isFirstTime == true) {
      isFirstTime = false;
      saveTutorial();
      setState(() {});
    } else {
      isFirstTime = true;
    }
  }

  Widget getDataInfo() {
    print(" CustomView :: ${homeController.uploads_type}");
    print(" CustomView :: ${homeController.multiple_images.toString()}");
    print(" CustomView :: ${homeController.image}");

    if (homeController.uploads_type == "image") {
      return getImageOrSlider();
    } else {
      List<String> clist = homeController.multiple_images.toString().split(",");
      return fullVideo(clist[0]);
    }
  }

  getImageOrSlider() {
    List<String> clist = homeController.multiple_images.toString().split(",");
    if (clist.length > 1) {
      return fullSlider(homeController.image, clist);
    } else {
      return fullImageView(clist[0]);
    }
  }

  Widget fullImageView(String imageUrl) {
    print("Url VIdeo Selected :: $imageUrl");
    return Stack(children: [
      Positioned.fill(
          child: Container(
        color: Colors.white,
        child: NewsItemImageFull(
          title: "article.title",
          imageUrl: imageUrl,
          description: "",
          author: "",
          source: "",
          link: false,
        ),
      )),
    ]);
  }

  Widget fullVideo(String url) {
    return Stack(children: [
      Positioned.fill(
          child: Container(
        color: Colors.white,
        child: NewsItemVideo(
          title: "article.title",
          imageUrl: url,
          description: "",
          author: "",
          source: "",
          link: false,
        ),
      ))
    ]);
  }

  Widget fullSlider(String imageBack, List<String> sliderImage) {
    return Stack(children: [
      Positioned.fill(
          child: Container(
        color: Colors.white,
        child: NewsItemImageSlider(
          imageUrl: imageBack,
          description: sliderImage,
        ),
      )),
    ]);
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  fullShareView(KetitikModel article) {
    String withUrl = "";
    String image = article.image.toString();
    String author = article.author.toString();
    if (author == null || author.contains("nil")) {
      author = "As per Sources";
    }

    if (image.startsWith("http")) {
      withUrl = image;
    } else {
      withUrl = "http://83.136.219.147/" + image;
    }

    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Colors.white,
        )),
        NewsItemShare(
            title: article.title,
            imageUrl: image,
            description: article.description ?? "  ",
            author: author,
            source: article.source),
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
        /*Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: )),*/
      ],
    );
  }

  fullCourosolView(KetitikModel article, int index) {
    print("Index ::$index  :: Title ${article.title.toString()}");
    homeController.isLiked.value = false;
    String withUrl = "";
    String image = article.image.toString();
    String author = article.author.toString();
    if (author == null || author.contains("nil")) {
      author = "As per Sources";
    }

    if (image.startsWith("http")) {
      withUrl = image;
    } else {
      withUrl = "http://13.233.68.171/" + image;
    }

    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Colors.white,
        )),
        article.uploads_type == "video"
            ? NewsItemVideoss(
                title: article.title,
                imageUrl: withUrl,
                description: article.description ?? "  ",
                author: author,
                source: article.source,
                link: false,
              )
            : NewsItem(
                title: article.title,
                imageUrl: withUrl,
                description: article.description ?? "  ",
                author: author,
                source: article.source,
                link: false,
              ),
        Positioned(
          left: 5,
          bottom: 52,
          child: GestureDetector(
            onTap: () {
              if (homeController.isLiked.value == true) {
                homeController.isLiked.value = false;
              } else {
                homeController.isLiked.value = true;
              }
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                10,
              )),
              child: Obx(
                () => Center(
                    child: homeController.isLiked.value
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
        ),
        Positioned(
          right: 0,
          bottom: 52,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              //alignment: FractionalOffset.bottomCenter,
              child: GestureDetector(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: homeController.isLoggedin.value,
                      child: GestureDetector(
                        onTap: () async {
                          // getUserToken();
                          _apiService.addBookmark(
                            article.url,
                            article.id.toString(),
                            article.title,
                          );
                          homeController.updateValueList(index);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                            10,
                          )),
                          child: Obx(
                            () => Center(
                              child: homeController.bookmarkStatus.value == 0
                                  ? Icon(
                                      Icons.bookmark_border,
                                      color: MyColors.themeBlackTrans,
                                      size: 25,
                                    )
                                  : Icon(
                                      Icons.bookmark,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    GestureDetector(
                      onTap: () async {
                        ApplicationUtils.openDialog();

                        final imageFile = await screenshotController
                            .captureFromWidget(Container(
                                color: Colors.white,
                                child: fullShareView(article)));

                        ApplicationUtils.closeDialog();

                        if (imageFile != null) {
                          final directory = await getTemporaryDirectory();
                          //String fileName = getRandomString(5) + "image.png";
                          final imagePath =
                              await File('${directory.path}/image.png')
                                  .create();
                          await imagePath.writeAsBytes(imageFile);

                          SocialShare.shareOptions(
                              "Download keTitik, aplikasi berita Indonesia. Hemat waktu membaca berita dalam 60 kata \n App Store https://apps.apple.com/in/app/ketitik/id1632893056",
                              imagePath: imagePath.path);

                          //   await Share.shareFiles([imagePath.path],
                          //       text:
                          //           "Download keTitik, aplikasi berita Indonesia. Hemat waktu membaca berita dalam 60 kata \n Google Play : https://play.google.com/store/apps/details?id=com.app.ketitik.ketitik",
                          //       subject:
                          //           "Download keTitik, aplikasi berita Indonesia. Hemat waktu membaca berita dalam 60 kata \n Google Play : https://play.google.com/store/apps/details?id=com.app.ketitik.ketitik");
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
                Navigator.of(context)
                    .push(FullPageRoute(categoryNameFull, articleFull, newsId));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        image,
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
                      child: getBottomText(article.title.toString(), 50)),
                ),
              )),
        ),
      ],
    );
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

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

  bottomBarLoggedin() {
    return GNav(
      gap: 5,
      color: Colors.grey[800],
      activeColor: Colors.black,
      iconSize: 20,
      tabBackgroundColor: Colors.white.withOpacity(1.0),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
      duration: const Duration(milliseconds: 100),
      tabs: const [
        GButton(
          icon: Icons.book,
          text: 'All News',
          textStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.normal,
          ),
        ),
        GButton(
          icon: Icons.description,
          text: 'My Feeds',
          textStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.normal,
          ),
        ),
        GButton(
          icon: Icons.album,
          text: 'Top Stories',
          textStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.normal,
          ),
        ),
        GButton(
          icon: Icons.all_inclusive,
          text: 'Trending',
          textStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
      onTabChange: (index) {
        setState(() {
          selectedIndex = index;
          getTabData(selectedIndex);
        });
      },
    );
  }

  getTabData(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        homeController.filter.value = "allNews";
        homeController.getAllNewsData();
        break;
      case 1:
        homeController.filter.value = "feeds";
        homeController.getMyFeedData();
        break;
      case 2:
        homeController.filter.value = "top";
        homeController.getTopStoriesData();
        break;
      case 3:
        homeController.filter.value = "trending";
        homeController.getTrendingData();
        break;
      default:
        Timer(Duration(seconds: 1), () {
          homeController.filter.value = "allNews";
          homeController.getAllNewsData();
        });
        break;
    }
  }

  Container topBar(double widthfull) {
    double width = 20;
    double height = 20;
    return Container(
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
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const ProfilePage())),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/menu.png',
                      width: width,
                      height: height,
                      color: Colors.black,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Image.asset(
                  "assets/images/ketsquarezoom.png",
                  width: 105,
                  height: 80,
                ),
              ),
              const Spacer(),
              InkWell(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ImageIcon(
                        AssetImage('assets/images/refresh.png'),
                        size: 20,
                        color: Colors.black,
                      )),
                  onTap: () => {
                        setState(() {
                          getTabData(selectedIndex);
                        })
                      }),
              InkWell(
                  child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: ImageIcon(
                        AssetImage('assets/images/searchbar.png'),
                        size: 27,
                        color: Colors.black,
                      )),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const SearchPage()))),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          bottomBarLoggedin()
        ],
      ),
    );
  }

  void firebaseCloudMessaging_Listeners() async {
    print("fbcalled");

    WidgetsBinding.instance?.addPostFrameCallback((duration) async {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('User granted permission: ${settings.authorizationStatus}');

      // 1. This method call when app in terminated state and you get a notification
      // when you click on notification app open from terminated state and you can get notification data in this method

      FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
          print("FirebaseMessaging.instance.getInitialMessage");
          if (message != null) {
            //notificationController.getNotificationList();
            print("New Notification");
            // if (message.data['_id'] != null) {
            //   Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (context) => DemoScreen(
            //         id: message.data['_id'],
            //       ),
            //     ),
            //   );
            // }
            Get.to(NotificationDetailPage("id"));
          }
        },
      );

      // 2. This method only call when App in forground it mean app must be opened
      FirebaseMessaging.onMessage.listen(
        (message) {
          print("FirebaseMessaging.onMessage.listen");
          if (message.notification != null) {
            //notificationController.getNotificationList();
            print(message.notification!.title);
            print(message.notification!.body);
            print("message.data11 ${message.data}");
            /*LocalNotificationService.createanddisplaynotification(message);*/
            Get.to(NotificationDetailPage("id"));
          }
        },
      );

      // 3. This method only call when App in background and not terminated(not closed)
      FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
          // notificationController.getNotificationList();
          print("FirebaseMessaging.onMessageOpenedApp.listen");
          if (message.notification != null) {
            //notificationController.getNotificationList();
            print(message.notification!.title);
            print(message.notification!.body);
            print("message.data22 ${message.data['_id']}");
            Get.to(NotificationDetailPage("id"));
          }
        },
      );

      _firebaseMessaging.getToken().then((token) {
        print("firebase token>");
        // if (token != null) getUserInfoController.saveFcm(token);
        print(token);
      });
    });
    // if (Platform.isIOS) iOS_Permission();
  }
}
