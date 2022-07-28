import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketitik/utility/PreferenceModel.dart';
import 'package:ketitik/utility/colorss.dart';

class GridItem extends StatefulWidget {
  final Key key;
  final PreferenceModelSve item;
  final ValueChanged<bool> isSelected;
  bool isSelectedVal = false;

  GridItem(
      {required this.item,
      required this.isSelectedVal,
      required this.isSelected,
      required this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelectedVal;
    print("Current Status :: $isSelected");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isSelected) {
          isSelected = false;
        } else {
          isSelected = true;
        }
        widget.isSelectedVal = isSelected;
        print("Current Status On Tap :: ${widget.isSelectedVal}");
        widget.isSelected(widget.isSelectedVal);
        print("Current Status On Tap :: ${widget.isSelected}");
/*        setState(() {

        });*/
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                  "https://13.233.68.171/${widget.item.imageUrl}")),
          Opacity(
              opacity: 0.6,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyColors.themeBlackTrans, Colors.black38],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ))),
          Center(
              child: Text(
            widget.item.name.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          )),
          isSelected
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.yellow,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
