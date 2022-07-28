import 'package:flutter/material.dart';

class NewsItemImageFull extends StatefulWidget {
  String? title;
  String? imageUrl;
  String? description;
  String? author;
  String? source;
  bool? link;

  NewsItemImageFull({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.source,
    this.link,
  }) : super(key: key);

  @override
  State<NewsItemImageFull> createState() => NewsItemVideoState();
}

class NewsItemVideoState extends State<NewsItemImageFull> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.777;
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const SizedBox(
            height: 10,
          ),
          FadeInImage.assetNetwork(
            image: widget.imageUrl.toString(),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/dummy_news.jpg',
                  fit: BoxFit.cover);
            },
            placeholder: 'assets/images/dummy_news.jpg',
            // your assets image path
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
