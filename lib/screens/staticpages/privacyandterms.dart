import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ketitik/services/api_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utility/colorss.dart';

class TermsPrivacyPage extends StatefulWidget {
  final String fullnewsUrl;

  const TermsPrivacyPage({Key? key, required this.fullnewsUrl})
      : super(key: key);

  @override
  _FullNewsPageState createState() => _FullNewsPageState();
}

class _FullNewsPageState extends State<TermsPrivacyPage> {
  bool isLoading = true;
  String pageTitle = "";
  String dataString = "";
  APIService apiService = APIService();

  //bool isLoading = true;
  String termsandCondition = "";

  @override
  void initState() {
    super.initState();
    if (widget.fullnewsUrl == "terms") {
      pageTitle = "Terms and Services";
      termsandCondition = "https://netdemo.site/KeTitik/termios.html";
    } else {
      pageTitle = "Privacy Policy";
      termsandCondition = "https://netdemo.site/KeTitik/privacyios.html";
    }
  }

  /* Future<String> getUserData({pagename}) async {
    String dataStatic = "";
    if (pagename == "terms") {
      dataStatic ="https://netdemo.site/KeTitik/privacyios.html";
    } else {
      dataStatic = (await apiService.getStaticPrivacy());
    }

    print("Data - ${dataString}");
    String withMetaData = (""""<!DOCTYPE html>
<html>
        <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta name="apple-mobile-web-app-capable" content="yes">
        </head>
<body>
<div>
$dataStatic
</div>
    </body>
    </html>""");

    String completeHtml = await addFontToHtml(
        withMetaData, "assets/fonts/Montserrat-Regular.ttf", "font/opentype");

    return completeHtml;
  }*/

  String getFontUri(ByteData data, String mime) {
    final buffer = data.buffer;
    return Uri.dataFromBytes(
            buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
            mimeType: mime)
        .toString();
  }

  Future<String> addFontToHtml(
      String htmlContent, String fontAssetPath, String fontMime) async {
    final fontData = await rootBundle.load(fontAssetPath);
    final fontUri = getFontUri(fontData, fontMime).toString();
    final fontCss =
        '@font-face { font-family: Montserrat; src: url($fontUri); } * { font-family: Montserrat; } * {  font-size: 13pt; }';
    return '<style>$fontCss</style>$htmlContent';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              margin: EdgeInsets.only(top: 60),
              child: WebView(
                initialUrl: termsandCondition,
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
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
            Container(
              height: 55,
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
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(
                        width: 90,
                      ),
                      Text(
                        pageTitle,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
