import 'package:flutter/material.dart';

class NewsItem extends StatefulWidget {
  String? title;
  String? imageUrl;
  String? description;
  String? author;
  String? source;
  bool? link;

  NewsItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.source,
    this.link,
  }) : super(key: key);

  @override
  State<NewsItem> createState() => NewsItemState();
}

class NewsItemState extends State<NewsItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      print("Image Url :: ${widget.imageUrl}");
    });
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
              child: FadeInImage.assetNetwork(
                height: 250,
                image: widget.imageUrl!,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/dummy_news.jpg',
                      fit: BoxFit.fitWidth);
                },
                placeholder: 'assets/images/dummy_news.jpg',
                // your assets image path
                fit: BoxFit.cover,
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
                widget.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
            height: 0,
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
                    height: 3,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        widget.description!,
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
                    height: 3,
                  ),
                  widget.source == "---" ||
                          widget.source == null ||
                          widget.source == "null"
                      ? Text("")
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text("Source : ${widget.source!}",
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
                        ),
                  Visibility(
                    visible: widget.link == true ? true : false,
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
