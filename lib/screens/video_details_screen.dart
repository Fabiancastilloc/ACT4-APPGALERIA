import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:galeria_reales/models/video_model.dart';

class VideoDetailsScreen extends StatefulWidget {
  final VideoModel video;

  VideoDetailsScreen({required this.video});

  @override
  _VideoDetailsScreenState createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    final videoUrl = widget.video.videos?['large']?['url'] ?? '';

    final videoUri = Uri.parse(videoUrl);

    _videoPlayerController = VideoPlayerController.networkUrl(
      videoUri,
      httpHeaders: {},
    );
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      placeholder: Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );

    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Video'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: _videoPlayerController.value.isInitialized
                ? Chewie(controller: _chewieController)
                : Container(
                    color: Colors.black,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Descripción del video o cualquier otro contenido que desees agregar.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
