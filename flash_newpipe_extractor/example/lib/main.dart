import 'dart:developer';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'test.dart';

void main() {
  runApp(Test());
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
          // _video =
          //     await extract.getTrendingVideos().then((value) => value![20]);
          // if (_video != null) {
          //   print(_video!.uploaderName);
          // }

          // await _video!.getFullInformation.then((value) async {
          //   value.getComments().then(
          //     (value) async {
          //       await value!
          //           .nextpageItems()
          //           .then((v) => print(value.commentsInfo.length));
          //     },
          //   );
          // });
// print(_video!.videoInfo!.comments!.page!.id);
          // if (_video!.videoInfo!.comments!.page!.hasNextPage) {
          //   await _video!.videoInfo!.comments!.nextpageItems();
          //   _video!.videoInfo!.comments!.commentsInfo.forEach((element) {
          //     print(element.commentText);
          //   });
          // } else {
          //   print("next page");
          // }

          // await _video!.getUploaderChannelInfo().then((value) async {
          //   print(value!.videoUploads.length);
          //   // for (var name in value!.videoUploads) {
          //   //   print(name.videoName);
          //   // }
          //   print(
          //       "::::::::::::::::::::::::::::::::::::::: next page ::::::::::::::::::::::::::::::");
          //   await value
          //       .nextpageItems()
          //       .then((v) => print(value.videoUploads.length));
          // });
          if (_video!.uploaderChannelInfo!.page!.hasNextPage) {
            await _video!.uploaderChannelInfo!.nextpageItems();
            print(_video!.uploaderChannelInfo!.videoUploads.length);
            print(_video!.uploaderChannelInfo!.page!.pageNumber);
          } else {
            print("no next page");
          }
        },
      ),
    ));
  }
}
