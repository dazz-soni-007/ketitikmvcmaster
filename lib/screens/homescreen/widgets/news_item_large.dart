import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsItemLarge extends StatelessWidget {
  String? title;
  String? imageUrl;
  String? description;
  String? author;
  String? source;
  bool? link;

  NewsItemLarge({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.source,
    this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                height: 250,
                placeholder: (context, url) =>
                    Image.asset('assets/images/dummy_news.jpg'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/dummy_news.jpg'),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              margin: const EdgeInsets.all(5.0),
              semanticContainer: true,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        description!,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  /* const Spacer(),
                      IconButton(
                        icon: const Icon(MyFlutterApp.bookmark_border,
                            size: 22, color: Colors.black),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(MyFlutterApp.share,
                            size: 22, color: Colors.black),
                        onPressed: () {},
                      ),*/
                  /* author == "---" || author == null || author == "null"
                      ? Text("")
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text("Author : ${author!}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.clip),
                              ),
                            ),
                          ],
                        ),*/
                  source == "---" || source == null || source == "null"
                      ? Text("")
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text("Source : ${source!}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.clip),
                              ),
                            ),
                          ],
                        ),
                  Visibility(
                    visible: link == true ? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Image.asset(
                              "assets/images/redketifull.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
