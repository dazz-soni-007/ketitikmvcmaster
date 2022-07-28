import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketitik/controller/profile_controller.dart';
import 'package:ketitik/screens/auth/controller/login_controller.dart';
import 'package:ketitik/screens/auth/views/login_screen.dart';
import 'package:ketitik/screens/prefrences/preferencemodel.dart';
import 'package:ketitik/screens/prefrences/views/edit_prefrence_screen.dart';
import 'package:ketitik/screens/staticpages/fulltutorial.dart';
import 'package:ketitik/services/api_service.dart';
import 'package:ketitik/utility/app_route.dart';
import 'package:ketitik/utility/application_utils.dart';
import 'package:ketitik/utility/colorss.dart';
import 'package:ketitik/utility/prefrence_service.dart';
import 'package:ketitik/utility/swipeaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editprofile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

getUserDetails() {}

class _ProfilePageState extends State<ProfilePage> {
  var controller = Get.find<LoginController>();
  var loginStatus = false;
  var apiservice = APIService();

  ProfileController profileController = ProfileController();
  PrefrenceService prefrenceService = PrefrenceService();
  APIService _apiService = APIService();
  List<CategoryName> savedList = [];
  String path = "";
  String deviceId = "";

  @override
  void initState() {
    super.initState();
    profileController.getUserData();
    getDeviceData();
    path = ApplicationUtils.getAvatarImage(
        profileController.avatarPos.value.toString());
  }

  getDeviceData() async {
    deviceId = await ApplicationUtils.getDeviceDetails();
  }

  getSelectedData() async {
    ApplicationUtils.openDialog();
    print("profiledata $deviceId");
    savedList = await _apiService.getMyPreference(deviceId);

    ApplicationUtils.closeDialog();
    //print("${savedList.length}  ${savedList[0].categories}");
    Get.to(() => MyPrefrenceScreen(
          cateName: savedList,
        ));
  }

  Stack profileTopContainer() {
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: MyColors.themeColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              border: Border.all(
                width: 3,
                color: MyColors.themeColor,
                style: BorderStyle.solid,
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  //ApplicationUtils.onBackPress(context)
                  children: [
                    InkWell(
                      child: Image.asset(
                        "assets/images/left.png",
                        height: 25,
                        width: 25,
                      ),
                      onTap: () => {ApplicationUtils.onBackPress(context)},
                    ),
                    const SizedBox(
                      width: 125,
                    ),
                    const Text(
                      "My Profile",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    InkWell(
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ),
                              ).then((value) {
                                profileController.getUserData();
                              })
                            }),
                  ],
                )),
          ),
          Positioned(
              bottom: -100.0,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                            radius: 45,
                            backgroundImage: path == ""
                                ? AssetImage(profileController.avatarPos.value)
                                : AssetImage("assets/images/menavatarnew.png")),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              profileController.name.value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => Text(
                              profileController.email.value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ])))
        ]);
  }

  TopBar() {
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
              onTap: () => {ApplicationUtils.onBackPress(context)},
            ),
            const SizedBox(
              width: 15,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Profile",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

/*return GestureDetector(
                          onHorizontalDragEnd: (DragEndDetails details) {
                            if (details.primaryVelocity! > 0) {
                              // User swiped Left
                              Navigator.of(context).push(ProfilePageRoute());
                            } else if (details.primaryVelocity! < 0) {
                              // User swiped Right
                              Navigator.of(context)
                                  .push(FullPageRoute(articleFull, newsId));
                            }
                          },*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          // User swiped Left
          print("left");
          // Navigator.of(context).push(ProfilePageRoute());
        } else if (details.primaryVelocity! < 0) {
          // User swiped Right
          print("right");
          ApplicationUtils.popCurrentPage(context);
          //Get.off(MyHomePage());
        }
      },
      child: Scaffold(
        body: Obx(
          () => Column(
            children: [
              profileController.isLoggedIn.value
                  ? profileTopContainer()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TopBar(),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Account',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 15),
                          child: Text(
                            'Login to view your profile',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 15),
                          child: Text(
                            'By clicking Log in, you agree with our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 100),
                                onPrimary: Colors.black,
                                primary: Theme.of(context).primaryColor),
                            onPressed: () {
                              Get.to(
                                () => const LoginScreen(),
                              );
                            },
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
              profileController.isLoggedIn.value
                  ? const SizedBox(
                      height: 110,
                    )
                  : const SizedBox(
                      height: 30,
                    ),
              Divider(
                height: 2,
                color: MyColors.themeBlackTrans,
              ),
              profileController.isLoggedIn.value
                  ? getAuthMenuView()
                  : getMenuView(),
            ],
          ),
        ),
      ),
    ));
  }

  getMenuView() {
    return Column(
      children: [
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.bookmarks_outlined),
          title: const Text(
            'My Bookmarks',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Get.toNamed(RoutingNameConstants.BOOKMARK_SCREEN_ROUTE),
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.animation),
          title: const Text(
            'How to Use',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Get.to(FullTutorial()),
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.workspaces_outline),
          title: const Text(
            'My Saved Preferences',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => getSelectedData(),
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.list),
          title: const Text(
            'Terms and Conditions',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Navigator.of(context).push(TermsPrivacyRoute("terms")),
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.list),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Navigator.of(context).push(TermsPrivacyRoute("privacy")),
        ),
      ],
    );
  }

  getAuthMenuView() {
    return Column(
      children: [
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.bookmarks_outlined),
          title: const Text(
            'My Bookmarks',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Get.toNamed(RoutingNameConstants.BOOKMARK_SCREEN_ROUTE),
        ),
        const Divider(
          height: 2,
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.animation),
          title: const Text(
            'How to Use',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Get.to(FullTutorial()),
        ),
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.workspaces_outline),
          title: const Text(
            'My Saved Preferences',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => getSelectedData(),
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.list),
          title: const Text(
            'Terms and Conditions',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Navigator.of(context).push(TermsPrivacyRoute("terms")),
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
          iconColor: MyColors.blankTrans,
          leading: const Icon(Icons.list),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Navigator.of(context).push(TermsPrivacyRoute("privacy")),
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
            iconColor: MyColors.blankTrans,
            leading: const Icon(Icons.delete_forever),
            title: const Text(
              'Delete Account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _showMyDialog()),
        ListTile(
            iconColor: MyColors.blankTrans,
            leading: const Icon(Icons.logout),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => logout())
      ],
    );
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.clear().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false));
    //Get.off(LoginScreen());
  }

  deleteAccount() async {
    ApplicationUtils.openDialog();
    // delete user account
    await apiservice.deleteUser(deviceId);
    ApplicationUtils.closeDialog();
    // navigating to login screen
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Account',
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Are you sure you want to delete account permanently?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                print('Confirmed');
                deleteAccount();
                //Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
