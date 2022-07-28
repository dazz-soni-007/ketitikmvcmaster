import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketitik/screens/staticpages/tutorialpagewithout.dart';

import '../../utility/colorss.dart';

class FullTutorial extends StatefulWidget {
  FullTutorial({Key? key}) : super(key: key);

  @override
  _FullNewsPageState createState() => _FullNewsPageState();
}

class _FullNewsPageState extends State<FullTutorial> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.themeColor,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text(
            'How to Use',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: TutorialPagesWithout());
  }
}
