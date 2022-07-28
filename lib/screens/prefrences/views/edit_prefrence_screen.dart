import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/category.dart';
import '../../../services/api_service.dart';
import '../../../utility/PreferenceModel.dart';
import '../../../utility/application_utils.dart';
import '../../../utility/colorss.dart';
import '../../../utility/prefrence_service.dart';
import '../../homescreen/view/home_screen.dart';
import '../preferencemodel.dart';
import '../widget/grid_item.dart';

class MyPrefrenceScreen extends StatefulWidget {
  List<CategoryName> cateName = [];

  MyPrefrenceScreen({Key? key, required this.cateName}) : super(key: key);

  @override
  State<MyPrefrenceScreen> createState() => _PrefrenceScreenState();
}

class _PrefrenceScreenState extends State<MyPrefrenceScreen> {
  List<PreferenceModelSve> itemList = [];
  List<String> selectedStrList = [];
  PrefrenceService prefrenceService = PrefrenceService();

  List<Preference> allList = [];
  final APIService _apiService = APIService();

  var deviceId = "";

  @override
  void initState() {
    super.initState();
    bindSavedData();
    getData();
  }

  getSelectedData() {
    for (int i = 0; i < widget.cateName.length; i++) {
      print("Selected ONly ${widget.cateName[i].categories}");
    }
  }

  getData() async {
    deviceId = await ApplicationUtils.getDeviceDetails();
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
                "My Saved Preferences",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  bindSavedData() {
    for (int i = 0; i < widget.cateName.length; i++) {
      selectedStrList.add(widget.cateName[i].id.toString());
    }
  }

  bool getSavedStatus(String categoryName) {
    bool isSaved = false;
    for (int i = 0; i < widget.cateName.length; i++) {
      if (categoryName == widget.cateName[i].categories) {
        isSaved = true;
      }
    }
    return isSaved;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              SizedBox(
                height: 5,
              ),
              //showContent(),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: FutureBuilder<List<Preference>>(
                    future: _apiService.getCategory(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      allList = snapshot.data!;
                      getDataTotal(allList);
                      return GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: itemList.length,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            return GridItem(
                                item: itemList[index],
                                isSelectedVal:
                                    getSavedStatus(itemList[index].name),
                                isSelected: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedStrList.add(itemList[index].id);
                                      print(
                                          "List Size After Remove${selectedStrList.length}");
                                      //selectedList.add(itemList[index]);
                                    } else {
                                      //selectedList.remove(itemList[index]);
                                      int indexDelete =
                                          getIndex(itemList[index].id);
                                      print(
                                          "List Item for Remove$indexDelete ${itemList[index].name}");
                                      selectedStrList.removeAt(indexDelete);
                                      print(
                                          "List Size After Remove${selectedStrList.length}");
                                    }
                                  });
                                  //print("------ selected ${selectedList.length.toString()}");
                                  // print("$index : $value");
                                },
                                key: Key(itemList[index].id.toString()));
                          });
                    }),
              ),
              Container(
                width: 200,
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      primary: MyColors.themeColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: MyColors.themeColor,
                      )),
                  child: const Text(
                    'Update Preference',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    //bindSavedData();
                    //getDataSelected();
                    // ApplicationUtils.openDialog();
                    print("API selectedCat  :${selectedStrList.toString()}");

                    var selectedCat = await _apiService.saveUserPrefrence(
                        selectedStrList.toString(), deviceId);
                    print("selectedCatList :${selectedStrList.toString()}");
                    if (selectedCat["status"] == true) {
                      selectedStrList.clear();
                      ApplicationUtils.closeDialog();
                      Get.to(
                        () => MyHomePage.withA(),
                      );
                    } else {
                      ApplicationUtils.closeDialog();
                      selectedStrList.clear();
                      Get.snackbar('Error', 'Something Went Wrong');
                    }
                    print("deviceId ${deviceId.toString()}");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int getIndex(String item) {
    int index = 0;
    for (int i = 0; i < selectedStrList.length; i++) {
      if (selectedStrList[i] == item) {
        index = i;
      }
    }
    return index;
  }

  getDataTotal(List<Preference> list) {
    itemList.clear();
    for (int i = 0; i < list.length; i++) {
      Preference pref = list[i];
      itemList.add(PreferenceModelSve(
          list[i].thumbImage, pref.categories.toString(), pref.id.toString()));
      //print("-----------${itemList[i].name}");
    }
    print("${itemList.length.toString()}");
  }
}
