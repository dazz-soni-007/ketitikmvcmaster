import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketitik/controller/home_controller.dart';
import 'package:ketitik/utility/colorss.dart';

class TutorialPagesWithout extends StatefulWidget {
  const TutorialPagesWithout({Key? key}) : super(key: key);

  @override
  State<TutorialPagesWithout> createState() => _TutorialPagesState();
}

class _TutorialPagesState extends State<TutorialPagesWithout> {
  HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColors.blankTrans,
        child: Stack(children: [
          Positioned(
              top: -30,
              right: 0,
              left: 0, //<-- SEE HERE
              child: Align(
                  alignment: Alignment.topCenter,
                  child: new RotatedBox(
                    quarterTurns: 0,
                    child: Image.asset(
                      "assets/images/tutotop.png",
                    ),
                  ))),
          Positioned(
              top: 240,
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
              bottom: -40, //<-- SEE HERE
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
        ]));
  }
}
