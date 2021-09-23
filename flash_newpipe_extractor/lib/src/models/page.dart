import 'package:flash_newpipe_extractor/src/method_calls.dart';
import 'package:flash_newpipe_extractor/src/models/channel.dart';
import 'dart:typed_data';

class Page {
  final String? id;
  final String? url;
  final Uint8List? body;
  final int pageNumber;
  final List<String>? ids;
  final bool hasNextPage;

  Page(
      {this.id,
      this.url,
      this.pageNumber = 1,
      this.body,
      this.ids,
      this.hasNextPage = false});
  Page copyWith(
      {String? id,
      String? url,
      int? pageNumber,
      List<String>? ids,
      bool? hasNextPage,
      Uint8List? body}) {
    return Page(
      body: body ?? this.body,
      url: url ?? this.url,
      id: id ?? this.id,
      ids: ids ?? this.ids,
      pageNumber: pageNumber ?? this.pageNumber,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  void nextpageItems() async {
    await FlashMethodCalls.getChannelNextPageItems(this);
    // return _channel!.addToVideoList(video);
  }

  Channel? _channel;
  Channel? get getChannel => _channel;
  set channel(Channel? channel) {
    _channel = channel;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": _channel!.id,
      "url": url,
      "body": body,
      "ids": ids,
    };
  }

  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(
      url: map["url"],
      id: map["id"],
      hasNextPage: map["channelHasNextPage"],
      ids: List.from(map["ids"]),
      body: map["body"] as Uint8List?,
    );
  }
}
