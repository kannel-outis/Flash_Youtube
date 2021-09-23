import 'dart:developer';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  YoutubeVideo? _video;
  final String dummyEmptyChannel =
      "https://www.youtube.com/channel/UC3Zgh4DgfCqYxcEgQO6Y9_w";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: TextButton(
        onPressed: () {},
        child: Center(
          child: Text("press"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final extract = Extract();
          // await extract.getTrendingVideos().then((value) async {
          //   value![70].getFullInformation.then((value) =>
          //       value.getStreamOfQuality<VideoAudioStream>(Quality.large));
          // });
          _video =
              await extract.getTrendingVideos().then((value) => value![20]);
          if (_video != null) {
            print(_video!.uploaderName);
          }

          // await _video!.getFullInformation.then((value) async {
          //   value.getComments().then(
          //     (value) {
          //       value!.comments!.forEach((element) {
          //         print(element.commentText);
          //       });
          //     },
          //   );
          // });

          await _video!.getUploaderChannelInfo().then((value) {
            for (var name in value!.videoUploads) {
              print(name.videoName);
            }
            print(
                "::::::::::::::::::::::::::::::::::::::: next page ::::::::::::::::::::::::::::::");
            value.nextpage!.nextpageItems();
            // print(value!.nextpage!.body);
          });
        },
      ),
    ));
  }
}
