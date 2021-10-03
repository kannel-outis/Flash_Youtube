import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late final TextEditingController _controller;
  List<String> _suggestions = [];
  Search? _search;

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
                // Extract()
                //     .getPlaylistInfo(_controller.value.text)
                //     .then((value) async {
                //   print(value.growableListItems.length);
                //   if (value.page!.hasNextPage) {
                //     await value.nextpageItems();
                //     print(value.growableListItems.length);
                //   }
                // });

                // _search =
                //     await Extract().getSearchResults(_controller.value.text);
                // print(_search!.type);
                //     .then((value) {
                //   print(value.growableListItems
                //       .firstWhere((element) => element is Channel)
                //       .name);
                // });
                // print(_search!.metaInfo);
                // if (_search!.page!.hasNextPage)
                //   await _search!.nextpageItems().then(
                //       (value) => print(_search!.growableListItems.length));
                // else
                //   print("done");
                // for (var item in _search!.growableListItems) {
                //   print(item.name);
                // }
                await (_search!.growableListItems[12] as YoutubeVideo)
                    .getFullInformation
                    .then((value) async => print(await value
                        .getStreamOfQuality<AudioOnlyStream>(Quality.hd1080)
                        .streams!
                        .streamSize));
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
