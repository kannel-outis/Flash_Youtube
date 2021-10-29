import 'dart:developer';

import 'package:flash_utils/flash_pip/pip.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flash_utils/flash_utils.dart';
import 'package:youtube_player/youtube_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Plugin example app'),
      //   ),
      //   body: Column(
      //     children: [
      //       const Center(
      //         child: Text('Running on: '),
      //       ),
      //       // TextButton(
      //       //   onPressed: () {
      //       //     FlashUtils.enterPiPMode(200, 200);
      //       //   },
      //       //   child: const Center(
      //       //     child: Text("emir"),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      home: Testingpage2(),
    );
  }
}

class Testingpage2 extends StatefulWidget {
  const Testingpage2({Key? key}) : super(key: key);

  @override
  _Testingpage2State createState() => _Testingpage2State();
}

class _Testingpage2State extends State<Testingpage2> {
  late final YoutubePlayerController _controller;
  bool isPipMode = false;
  String quality = "240p";
  // ignore: unused_field
  static const String youtubeLink =
      "https://www.youtube.com/watch?v=BS3HgiHPYcs";
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.link(
        youtubeLink: "https://www.youtube.com/watch?v=X3Ai6osw3Mk",
        quality: YoutubePlayerVideoQuality.quality_144p);
    // https://www.youtube.com/watch?v=X3Ai6osw3Mk
    // https://www.youtube.com/watch?v=r64_50ELf58
  }

  @override
  Widget build(BuildContext context) {
    return FlashPIP(
      // child:
      builder: (context, isPip, child) {
        return SafeArea(
          child: Scaffold(
            // appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: MediaQuery.of(context).orientation == Orientation.portrait
                //           ? MediaQuery.of(context).viewPadding.top
                //           : 0.0),
                // ),
                YoutubePlayer(
                  controller: _controller,
                  completelyHideProgressBar: isPip,
                  // size: const Size(20, 20),
                  hideProgressThumb: true,
                  onVideoQualityChange: (quality) {},
                ),

                if (!isPip)
                  TextButton(
                    onPressed: () {
                      FlashUtilsMethodCall.selectFolder()
                          .then((value) => print(value?.path));
                      return;
                      FlashUtilsMethodCall.enterPiPMode(9, 16).then(
                        (value) {
                          isPipMode = value;
                          setState(() {});
                        },
                      );
                    },
                    child: const Center(
                      child: Text("emir"),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
