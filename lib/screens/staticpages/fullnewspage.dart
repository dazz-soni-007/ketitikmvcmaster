import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketitik/services/api_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utility/colorss.dart';

class FullNewsPage extends StatefulWidget {
  final String? fullnewsUrl;
  final String newsId;
  final String categoryName;

  FullNewsPage(
      {Key? key,
      required this.categoryName,
      required this.newsId,
      required this.fullnewsUrl})
      : super(key: key);

  @override
  _FullNewsPageState createState() => _FullNewsPageState();
}

class _FullNewsPageState extends State<FullNewsPage> {
  bool isLoading = true;
  final _key = UniqueKey();
  APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    hitNewsCatgory();
  }

  hitNewsCatgory() async {
    String response = await apiService.updateSwipeCategory(widget.categoryName);
    print("update categoryname :: ${response.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    print("news page screen ${widget.fullnewsUrl}");
    /* GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          // User swiped Left
          print("left");
          // Navigator.of(context).push(ProfilePageRoute());
          ApplicationUtils.popCurrentPage(context);
        } else if (details.primaryVelocity! < 0) {
          // User swiped Right
          print("right");
          //Get.off(MyHomePage());
        }
      },*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.themeColor,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'KeTitik',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.fullnewsUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onProgress: (progress) {
              if (progress > 60) {
                setState(() {
                  isLoading = false;
                });
              }
            },
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
