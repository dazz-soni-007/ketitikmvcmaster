import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ketitik/services/api_service.dart';

import '../../controller/profile_controller.dart';
import '../../utility/application_utils.dart';
import '../../utility/colorss.dart';
import '../../utility/custom_textfield.dart';
import '../../utility/prefrence_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  int selectedIndex = 0;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ProfileController profileController = ProfileController();
  PrefrenceService prefrenceService = PrefrenceService();
  CustomController? _nameController;
  CustomController? _emailController;
  // CustomController? _contactController;

  String userName = "";

  //String userPhone = "";
  String userEmail = "";
  String userImageFile = "";
  List<String> avatarList = [];
  FocusNode focusName = FocusNode();
  FocusNode focusEmail = FocusNode();

  //FocusNode focusPhone = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = CustomController();
    _emailController = CustomController();
    //_contactController = CustomController();
    profileController.getUserData();
    addAvatarData();
  }

  addAvatarData() {
    avatarList.add("assets/images/menavatarnew.png");
    avatarList.add("assets/images/boyavatar.png");
    avatarList.add("assets/images/ladyavatar.png");
    avatarList.add("assets/images/girlavatar.png");
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return new WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return Future.value(false);
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: Container(
              width: width,
              height: height,
              child: Column(
                children: [
                  Container(
                    height: 60,
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
                          children: [
                            InkWell(
                              child: Image.asset(
                                "assets/images/left.png",
                                height: 25,
                                width: 25,
                              ),
                              onTap: () =>
                                  {ApplicationUtils.onBackPress(context)},
                            ),
                            const SizedBox(
                              width: 125,
                            ),
                            const Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      height: 90.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: avatarList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => {
                              setState(() {
                                selectedIndex = index;
                                prefrenceService
                                    .setAvatarImage(index.toString().trim());
                                profileController.avatarIndex.value = index;
                              })
                            },
                            child: Container(
                                width: 85,
                                height: 85,
                                //now suppose selectedIndex and index from this builder is same then it will show the selected as green and others in red color
                                child: Obx(
                                  () => Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                            radius: 45,
                                            backgroundColor:
                                                MyColors.themeColorYellow,
                                            child: CircleAvatar(
                                              radius: 38,
                                              backgroundImage:
                                                  AssetImage(avatarList[index]),
                                            )),
                                      ),
                                      index ==
                                              profileController
                                                  .avatarIndex.value
                                          ? Align(
                                              alignment: Alignment.topRight,
                                              child: Image.asset(
                                                "assets/images/checkmark.png",
                                                width: 15,
                                                height: 15,
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                )), //here you can show the child or data from the list
                          );
                        },
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 1.0, bottom: 1.0),
                          child: Text(
                            "User Name",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                            child: CustomTextBlack(
                              hintText: 'Name',
                              controller: _nameController!
                                ..text = profileController.name.value,
                              icon: const Icon(Icons.person),
                              keyboardType: TextInputType.name,
                              focusNode: focusName,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return "This Field is Required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _nameController!..text = value!;
                                profileController.name.value = value;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 1.0, bottom: 1.0),
                          child: Text(
                            "Email Address",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                            child: CustomTextBlack(
                              hintText: 'Email',
                              controller: _emailController!
                                ..text = profileController.email.value,
                              icon: const Icon(Icons.email),
                              keyboardType: TextInputType.emailAddress,
                              focusNode: focusEmail,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return "This Field is Required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailController!..text = value!;
                                profileController.email.value = value;
                              },
                            ),
                          ),
                        ),
                        /* Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 1.0, bottom: 1.0),
                          child: Text(
                            "Contact Number",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),*/
                        /*Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                            child: CustomTextBlack(
                              hintText: 'Contact Number',
                              controller: _contactController!
                                ..text = profileController.phone.value,
                              icon: const Icon(Icons.phone),
                              keyboardType: TextInputType.number,
                              focusNode: focusPhone,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return "This Field is Required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _contactController!..text = value!;
                                profileController.phone.value = value;
                              },
                            ),
                          ),
                        ),*/
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            child: const Text('Save Changes'),
                            style: ElevatedButton.styleFrom(
                              elevation: 6.0,
                              //shadowColor: MyColors.themeColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              primary: MyColors.blankTrans,
                            ),
                            onPressed: () {
                              onSubmit();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  onSubmit() async {
    focusName.unfocus();
    //focusPhone.unfocus();
    focusEmail.unfocus();

    APIService apiService = APIService();

    var email = _emailController!.text.toString();
    var name = _nameController!.text.toString();
    //var phone = _contactController!.text.toString();

    ApplicationUtils.openDialog();

    var response = await apiService.updateUserProfile(
        name, email, "", profileController.authToken.value);

    ApplicationUtils.closeDialog();
    print("${response.toString()}");
    var jsonDta = json.decode(response);
    print("${jsonDta.toString()}");
    var status = jsonDta["status"];
    var dataMessage = jsonDta["message"];
    showInSnackBar(dataMessage);

    if (status == true) {
      print("Saved asdasdas");

      profileController.name.value = name;
      //profileController.phone.value = phone;
      profileController.email.value = email;

      prefrenceService.setName(name);
      prefrenceService.setEmail(email);
      //prefrenceService.setPhone(phone);
    } else {
      ApplicationUtils.closeDialog();
    }
  }
}
