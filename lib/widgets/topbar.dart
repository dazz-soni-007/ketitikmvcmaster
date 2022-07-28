import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utility/swipeaction.dart';

class TopBar extends StatelessWidget {
  String title;

  TopBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => finishPage(context),
            child: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: const TextStyle(
                fontFamily: 'Montserrat', color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
