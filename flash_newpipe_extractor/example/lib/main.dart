import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          await FlashMethodCalls.getTrendingVideos().then((value) async {
            value![70].videoFullInformation.then((value) => null);
          });
        },
      ),
    ));
  }
}
