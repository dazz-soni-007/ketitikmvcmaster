import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketitik/controller/home_controller.dart';
import 'package:ketitik/utility/colorss.dart';

class TutorialPages extends StatefulWidget {
  const TutorialPages({Key? key}) : super(key: key);

  @override
  State<TutorialPages> createState() => _TutorialPagesState();
}

class _TutorialPagesState extends State<TutorialPages> {
  HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.blankTrans,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 15.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images/close.png",
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
              top: 11,
              right: 0,
              left: 0, //<-- SEE HERE
              child: Align(
                  alignment: Alignment.topCenter,
                  child: new RotatedBox(
                    quarterTurns: 0,
                    child: Image.asset(
                      "assets/images/tutotop.png",
                      color: MyColors.themeColor,
                    ),
                  ))),
          Positioned(
              top: 270,
              right: 0,
              left: 0, //<-- SEE HERE
              child: Align(
                  alignment: Alignment.center,
                  child: new RotatedBox(
                    quarterTurns: 0,
                    child: Image.asset(
                      "assets/images/tutomid.png",
                      width: 320,
                      height: 320,
                      color: MyColors.themeColor,
                    ),
                  ))),
          Positioned(
              bottom: -28, //<-- SEE HERE
              right: -9,
              left: 3,
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: new RotatedBox(
                    quarterTurns: 0,
                    child: Image.asset(
                      "assets/images/bottombuttns.png",
                      color: MyColors.themeColor,
                    ),
                  ))),
          /* Column(
            children: [
              Padding(
                padding: EdgeInsets.all(45),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: new RotatedBox(
                      quarterTurns: 3,
                      child: Image.asset(
                        "assets/images/rsarrowwhite.png",
                        width: 50,
                        height: 50,
                        color: MyColors.themeColor,
                      ),
                    )),
              ),
              Text("Swipe Up for Change News",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                    color: MyColors.themeColor,
                  ))
            ],
          ),
          Positioned(
              left: 0, //<-- SEE HERE
              top: 250,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: new RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(
                            "assets/images/rsarrowwhite.png",
                            width: 50,
                            height: 50,
                            color: MyColors.themeColor,
                          ),
                        )),
                  ),
                  Text("Swipe Left for Full News",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                        color: MyColors.themeColor,
                      )),
                ],
              )),
          Positioned(
              right: 0, //<-- SEE HERE
              top: 420,
              child: Row(
                children: [
                  Text("Swipe Right for Profile",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                        color: MyColors.themeColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: new RotatedBox(
                          quarterTurns: 4,
                          child: Image.asset(
                            "assets/images/rsarrowwhite.png",
                            width: 50,
                            height: 50,
                            color: MyColors.themeColor,
                          ),
                        )),
                  ),
                ],
              )),
          Positioned(
              right: 80, //<-- SEE HERE
              bottom: 0,
              child: Column(
                children: [
                  Text("Swipe Down for Change News",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                        color: MyColors.themeColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: new RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(
                            "assets/images/rsarrowwhite.png",
                            width: 50,
                            height: 50,
                            color: MyColors.themeColor,
                          ),
                        )),
                  ),
                ],
              )),*/
        ],
      ), /*Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 15.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images/close.png",
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(45),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: new RotatedBox(
                      quarterTurns: 3,
                      child: Image.asset(
                        "assets/images/rsarrowwhite.png",
                        width: 50,
                        height: 50,
                        color: MyColors.themeColor,
                      ),
                    )),
              ),
              Text("Swipe Up for Change News",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                    color: MyColors.themeColor,
                  ))
            ],
          ),
          Positioned(
              left: 0, //<-- SEE HERE
              top: 250,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: new RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(
                            "assets/images/rsarrowwhite.png",
                            width: 50,
                            height: 50,
                            color: MyColors.themeColor,
                          ),
                        )),
                  ),
                  Text("Swipe Left for Full News",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                        color: MyColors.themeColor,
                      )),
                ],
              )),
          Positioned(
              right: 0, //<-- SEE HERE
              top: 420,
              child: Row(
                children: [
                  Text("Swipe Right for Profile",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                        color: MyColors.themeColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: new RotatedBox(
                          quarterTurns: 4,
                          child: Image.asset(
                            "assets/images/rsarrowwhite.png",
                            width: 50,
                            height: 50,
                            color: MyColors.themeColor,
                          ),
                        )),
                  ),
                ],
              )),
          Positioned(
              right: 80, //<-- SEE HERE
              bottom: 0,
              child: Column(
                children: [
                  Text("Swipe Down for Change News",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                        color: MyColors.themeColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: new RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(
                            "assets/images/rsarrowwhite.png",
                            width: 50,
                            height: 50,
                            color: MyColors.themeColor,
                          ),
                        )),
                  ),
                ],
              )),
        ],
      ),*/
    );
  }
}
