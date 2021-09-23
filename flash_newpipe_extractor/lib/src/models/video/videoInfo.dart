import 'package:flash_newpipe_extractor/src/method_calls.dart';
import 'package:flash_newpipe_extractor/src/models/stream/_streamOfType_.dart';
import 'package:flash_newpipe_extractor/src/models/comment/comments.dart';
import 'package:flash_newpipe_extractor/src/models/stream/streams.dart';
import 'package:flash_newpipe_extractor/src/models/video/video.dart';
import 'package:flash_newpipe_extractor/src/utils/enums.dart';

import '../../utils/utils.dart';
import '../stream/audioOnlyStream.dart';
import '../stream/videoAudioStream.dart';
import '../stream/videoOnlyStream.dart';

class YoutubeVideoInfo {
  final String id;
  final String url;
  final String videoName;
  final String uploaderName;
  final String uploaderUrl;
  final String uploaderAvatarUrl;
  final String? textualUploadDate;
  final String? description;
  final int length;
  final int viewCount;
  final int likeCount;
  final int dislikeCount;
  final String? category;
  final int? ageLimit;
  final List<String>? tags;
  final String thumbnailUrl;
  final DateTime? uploadDate;

  YoutubeVideoInfo({
    required this.id,
    required this.url,
    required this.videoName,
    required this.uploaderName,
    required this.uploaderUrl,
    required this.uploaderAvatarUrl,
    this.textualUploadDate,
    this.description,
    required this.length,
    required this.viewCount,
    required this.likeCount,
    required this.dislikeCount,
    this.category,
    this.ageLimit,
    this.tags,
    required this.thumbnailUrl,
    this.uploadDate,
  });
  List<AudioOnlyStream> _audioOnlyStreams = [];
  List<VideoOnlyStream> _videoOnlyStreams = [];
  List<VideoAudioStream> _videoAudioStreams = [];
  List<YoutubeVideo> _relatedVideos = [];
  Comments? _comments;

  List<AudioOnlyStream> get audioOnlyStreams => _audioOnlyStreams;
  List<VideoOnlyStream> get videoOnlyStreams => _videoOnlyStreams;
  List<VideoAudioStream> get videoAudioStreams => _videoAudioStreams;
  List<YoutubeVideo> get relatedVideos => _relatedVideos;
  Comments? get comments => _comments;

  Future<Comments?> getComments() async {
    return _comments = await FlashMethodCalls.getvideoComments(url);
  }

  void addAudioOnlyStream(AudioOnlyStream stream) {
    _audioOnlyStreams.add(stream);
  }

  void addVideoOnlyStream(VideoOnlyStream stream) {
    _videoOnlyStreams.add(stream);
  }

  void addVideoAudioStream(VideoAudioStream stream) {
    _videoAudioStreams.add(stream);
  }

  void addRelatedVideo(YoutubeVideo relatedVideo) {
    _relatedVideos.add(relatedVideo);
  }

  StreamOfType<T> getStreamOfQuality<T extends Streams>(Quality quality) {
    switch (T) {
      case AudioOnlyStream:
        final value =
            _audioOnlyStreams.where((element) => element.quality == quality);
        if (value.isEmpty) {
          return StreamOfType<T>(null);
        }
        return StreamOfType<T>(value.first as T);
      case VideoOnlyStream:
        final value =
            _videoOnlyStreams.where((element) => element.quality == quality);
        if (value.isEmpty) {
          return StreamOfType<T>(null);
        }
        return StreamOfType<T>(value.first as T);
      default:
        final value =
            _videoAudioStreams.where((element) => element.quality == quality);
        if (value.isEmpty) {
          return StreamOfType<T>(null);
        }
        return StreamOfType<T>(value.first as T);
    }
  }

  static List<String> _getListFromString(String list) {
    final splitList = list.split(",");
    final splitListCount = splitList.length;
    final splitFirstItem = splitList.first.split("[");
    final splitLastItem = splitList.last.split("]");
    splitList[0] = splitFirstItem.last;
    splitList[splitListCount - 1] = splitLastItem.first;
    return splitList;
  }

  factory YoutubeVideoInfo.fromMap(Map<String, dynamic> map) {
    return YoutubeVideoInfo(
      id: map["id"],
      url: map["url"],
      videoName: map["videoName"],
      uploaderName: map["uploaderName"],
      uploaderUrl: map["uploaderUrl"],
      uploaderAvatarUrl: map["uploaderAvatarUrl"],
      textualUploadDate: map["textualUploadDate"],
      uploadDate: DateTime.tryParse(
        Utils.retrieveTime(
          map["uploadDate"],
        ),
      ),
      description: map["description"],
      length: map["length"],
      viewCount: map["viewCount"],
      likeCount: map["likeCount"],
      dislikeCount: map["dislikeCount"],
      category: map["category"],
      ageLimit: map["ageLimit"],
      // tags: List<String>.from(json.decode(map["tags"])),
      tags: _getListFromString(map["tags"]),
      thumbnailUrl: map["thumbnailUrl"],
    );
  }
}
