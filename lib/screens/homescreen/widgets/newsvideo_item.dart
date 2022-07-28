import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NewsItemVideo extends StatefulWidget {
  String? title;
  String? imageUrl;
  String? description;
  String? author;
  String? source;
  bool? link;

  NewsItemVideo({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.source,
    this.link,
  }) : super(key: key);

  @override
  State<NewsItemVideo> createState() => NewsItemVideoState();
}

class NewsItemVideoState extends State<NewsItemVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
//
  @override
  void initState() {
    super.initState();

    print("Video URL Video View :: ${widget.imageUrl.toString()}");
    _controller = VideoPlayerController.network(
      widget.imageUrl.toString(),
    );
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
      // If the video is paused, play it.
      _controller.play();
    });
    // Use the controller to loop the video.
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ));
                    /*child: SizedBox(
                          height: 550,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: VideoPlayer(_controller)),
                        ));*/
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
