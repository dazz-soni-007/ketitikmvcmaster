import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewsItemImageSlider extends StatefulWidget {
  String imageUrl;
  List<String> description;

  NewsItemImageSlider({
    Key? key,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  State<NewsItemImageSlider> createState() => NewsItemVideoState();
}

class NewsItemVideoState extends State<NewsItemImageSlider> {
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    images.addAll(widget.description);
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
            image: widget.imageUrl,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/dummy_news.jpg',
                  fit: BoxFit.cover);
            },
            placeholder: 'assets/images/dummy_news.jpg',
            // your assets image path
            fit: BoxFit.fitHeight,
          ),
          SizedBox(
            width: 250,
            height: 350,
            child: CarouselSlider.builder(
                carouselController: CarouselController(),
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  height: 350,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  viewportFraction: 0.6,
                  enlargeCenterPage: true,
                ),
                itemCount: images.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FadeInImage.assetNetwork(
                        image: images[itemIndex],
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/dummy_news.jpg',
                              fit: BoxFit.cover);
                        },
                        placeholder: 'assets/images/dummy_news.jpg',
                        // your assets image path
                        fit: BoxFit.cover,
                      ));
                }),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
