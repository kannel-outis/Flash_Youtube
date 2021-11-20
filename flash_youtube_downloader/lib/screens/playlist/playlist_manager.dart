import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';

class PlaylistManager {
  final List<YoutubeVideo>? initialPlayList;
  final bool growablePlayList;

  PlaylistManager({this.initialPlayList, this.growablePlayList = false}) {
    _playList = initialPlayList ?? <YoutubeVideo>[];
  }
  late final List<YoutubeVideo> _playList;
  List<YoutubeVideo> get playList => _playList;

  YoutubeVideo? _currentPlayingVideo;
  YoutubeVideo? get currentPlayingVideo => _currentPlayingVideo;
  void setCurrentPlayingVideo(YoutubeVideo? video,
      // ignore: avoid_positional_boolean_parameters
      [bool shouldAddVideo = true]) {
    _currentPlayingVideo = video;
    if (shouldAddVideo) {
      if (video != null && growablePlayList) _playList.add(video);
      if (!growablePlayList &&
          _playList.isNotEmpty &&
          !_playList.contains(video) &&
          video != null) {
        setNewPlayList([video]);
      }
    }
  }

  int _currentVideoIndex = 0;

  void playNext(YoutubeVideo nextVideo) {
    _playList.insert(_currentVideoIndex + 1, nextVideo);
  }

  YoutubeVideo? get nextVideo {
    _currentVideoIndex = _playList
        .map((e) => e.url)
        .toList()
        .indexWhere((element) => element == _currentPlayingVideo!.url);
    if (_hasNext) {
      return _playList[_currentVideoIndex + 1];
    }
    return null;
  }

  YoutubeVideo? get prevVideo {
    _currentVideoIndex = _playList
        .map((e) => e.url)
        .toList()
        .indexWhere((element) => element == _currentPlayingVideo!.url);
    print("$_currentVideoIndex :::::::::::::::::::::::::::::");
    if (_hasPrev) {
      return _playList[_currentVideoIndex - 1];
    }
    return null;
  }

  void clearPlayList() {
    _playList.clear();
  }

  void setNewPlayList(List<YoutubeVideo> newPlaylist) {
    _playList.clear();
    _playList.addAll(newPlaylist);
  }

  bool _hasNext = false;
  bool get hasNext {
    _hasNext = false;
    _currentVideoIndex = _playList
        .map((e) => e.url)
        .toList()
        .indexWhere((element) => element == _currentPlayingVideo!.url);

    if (_currentVideoIndex != (_playList.length - 1)) {
      _hasNext = true;
    }
    return _hasNext;
  }

  bool _hasPrev = false;
  bool get hasPrev {
    _hasPrev = false;
    _currentVideoIndex = _playList
        .map((e) => e.url)
        .toList()
        .indexWhere((element) => element == _currentPlayingVideo!.url);
    if (_currentVideoIndex != 0) {
      _hasPrev = true;
    }
    return _hasPrev;
  }
}
