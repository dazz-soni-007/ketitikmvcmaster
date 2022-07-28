import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NewsItemVideoLarge extends StatefulWidget {
  String? title;
  String? imageUrl;
  String? description;
  String? author;
  String? source;
  bool? link;

  NewsItemVideoLarge({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.source,
    this.link,
  }) : super(key: key);

  @override
  State<NewsItemVideoLarge> createState() => NewsItemVideoState();
}

class NewsItemVideoState extends State<NewsItemVideoLarge> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    print("Video URL :: ${widget.imageUrl.toString()}");
    _controller = VideoPlayerController.network(
      widget.imageUrl.toString(),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
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
                        child: SizedBox(
                          height: 250,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: VideoPlayer(_controller)),
                        ));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Wrap the play or pause in a call to `setState`. This ensures the
                      // correct icon is shown.
                      setState(() {
                        // If the video is playing, pause it.
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          // If the video is paused, play it.
                          _controller.play();
                        }
                      });
                    },
                    // Display the correct icon depending on the state of the player.
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
