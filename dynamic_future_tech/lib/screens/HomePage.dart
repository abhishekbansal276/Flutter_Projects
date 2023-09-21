import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: '3WqGAkOzsEo',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
        controlsVisibleAtStart: true,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: const Color(0xff6dd5ed),
          progressColors: const ProgressBarColors(
              playedColor: Color(0xff6dd5ed),
              handleColor: Colors.lightBlueAccent),
        ),
        builder: (context, player) {
          return Scaffold(
              appBar: AppBar(
                  title: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff6dd5ed).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: const Text(
                  "Home",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: Color(0xff2193b0),
                  ),
                ),
              )),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: player,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      child: Text(
                        "Top Categories",
                        style: TextStyle(
                          fontFamily: 'MontserratLight',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff2193b0),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
