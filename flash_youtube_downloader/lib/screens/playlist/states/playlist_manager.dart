import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';

class PlaylistManager {
  final List<YoutubeVideo>? playList;
  final bool growablePlayList;

  PlaylistManager({this.playList, this.growablePlayList = false}) {
    _playList = playList ?? <YoutubeVideo>[];
  }
  late final List<YoutubeVideo> _playList;

  YoutubeVideo? _currentPlayingVideo;
  YoutubeVideo? get currentPlayingVideo => _currentPlayingVideo;
  set currentPlayingVideo(YoutubeVideo? video) {
    _currentPlayingVideo = video;
    if (video != null && growablePlayList) _playList.add(video);
    if (!growablePlayList &&
        _playList.isNotEmpty &&
        !_playList.contains(video) &&
        video != null) {
      setNewPlayList([video]);
    }
  }

  int _currentVideoIndex = 0;

  YoutubeVideo? get nextVideo {
    if (_hasNext) {
      return _playList[_currentVideoIndex++];
    }
    return null;
  }

  YoutubeVideo? get prevVideo {
    if (_hasPrev) {
      return _playList[_currentVideoIndex--];
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
    if (_currentVideoIndex < _playList.length-- &&
        _currentVideoIndex != _playList.length--) {
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
