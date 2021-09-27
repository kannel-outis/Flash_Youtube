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
                await Extract().getSearchResults(_controller.value.text);
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
