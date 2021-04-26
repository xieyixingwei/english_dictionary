import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


class VedioPlayer extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const VedioPlayer({this.url});

  final String url;

  @override
  State<StatefulWidget> createState() {
    return _VedioPlayerState();
  }
}

class _VedioPlayerState extends State<VedioPlayer> {
  VideoPlayerController _videoCtrl;
  ChewieController _chewieCtrl;

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  @override
  void dispose() {
    _videoCtrl.dispose();
    _chewieCtrl?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoCtrl = VideoPlayerController.network(widget.url);
    await Future.wait([
      _videoCtrl.initialize(),
    ]);
    _chewieCtrl = ChewieController(
      videoPlayerController: _videoCtrl,
      autoPlay: false,
      looping: false,
      allowFullScreen: false,
      errorBuilder: (BuildContext context, String msg) => Text(msg),
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            _chewieCtrl != null && _chewieCtrl.videoPlayerController.value.isInitialized ?
            Container(
              width: 300,
              height: 400,
              child: AspectRatio(
                aspectRatio: _videoCtrl.value.aspectRatio,
                child: Chewie(controller: _chewieCtrl,),
              ),
            ) : 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading'),
                ],
              ),
          ],
    );
  }
}
