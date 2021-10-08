import 'package:hive/hive.dart';

import 'hive_youtube_video.dart';

// ignore: must_be_immutable
class HivePlaylist extends HiveObject {
  final List<HiveYoutubeVideo> videos;
  final String playlistName;

  HivePlaylist({
    required this.videos,
    required this.playlistName,
  });
}

class HivePlaylistAdapter extends TypeAdapter<HivePlaylist> {
  @override
  final int typeId = 3;

  @override
  HivePlaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePlaylist(
      videos: (fields[0] as List).cast<HiveYoutubeVideo>(),
      playlistName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HivePlaylist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.videos)
      ..writeByte(1)
      ..write(obj.playlistName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
