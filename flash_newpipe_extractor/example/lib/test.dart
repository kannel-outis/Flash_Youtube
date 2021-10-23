import 'dart:io';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late final TextEditingController _controller;
  List<String> _suggestions = [];
  Search? _search;
  int downloaded = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (value) async {
                // _suggestions = await Extract().getSearchSuggestions(value);
                // setState(() {});
              },
            ),
            // ListView(
            //   shrinkWrap: true,
            //   children: _suggestions
            //       .map(
            //         (e) => GestureDetector(
            //           onTap: () {
            //             _controller.value = TextEditingValue(text: e);
            //           },
            //           child: Container(
            //             height: 50,
            //             child: Center(child: Text(e)),
            //           ),
            //         ),
            //       )
            //       .toList(),
            // ),
            TextButton(
              onPressed: () async {
                // _search =
                //     await Extract().getSearchResults(_controller.value.text);

                // await (_search!.growableListItems[12] as YoutubeVideo)
                //     .getFullInformation
                //     .then((value) async => print(await value
                //         .getStreamOfQuality<AudioOnlyStream>(Quality.tiny)
                //         .streams!
                //         .streamSize));

                // final status = await Permission.storage.request();
                // final s = (_search!.growableListItems[12] as YoutubeVideo)
                //     .videoInfo!
                //     .getStreamOfQuality<AudioOnlyStream>(Quality.tiny)
                //     .streams!;
                // print(s.contentSize!.bytes);

                // if (status.isGranted) {
                // final dir = await getExternalStorageDirectory();
                // var knockDir = await Directory('${dir!.path}/downloader')
                //     .create(recursive: true);
                // final file = File(knockDir.path + "testing.${s.format}");

                //   s.downloadStream(
                //     file,
                //     start: downloaded,
                //     onCompleted: (value, size) {
                //       print(size.bytes);
                //       downloaded = size.bytes;
                //       print(value.path);
                //     },
                //     progressCallBack: (progress) {
                //       print(progress);
                //     },
                //   );
                // }

                // Future.delayed(const Duration(seconds: 1), () {
                // });
              },
              child: const Center(
                child: Text("testing"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
