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
          _video = await extract.getTrendingVideos().then((value) => value![0]);
          await _video!.getUploaderChannelInfo();
          _video!.uploaderChannelInfo!.videoUploads.forEach((element) {
            print(element.videoName);
          });
        },
      ),
    ));
  }
}
