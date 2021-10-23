import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'hive_youtube_video.dart';

// ignore: must_be_immutable
class HiveWatchHistory extends Equatable with HiveObjectMixin {
  final HiveYoutubeVideo video;

  HiveWatchHistory({
    required this.video,
  });

  @override
  List<Object?> get props => [
        video.url,
        video.uploadDate,
        video.uploaderName,
        video.textualUploadDate,
      ];
}

class HiveWatchHistoryAdapter extends TypeAdapter<HiveWatchHistory> {
  @override
  final int typeId = 2;

  @override
  HiveWatchHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveWatchHistory(
      video: fields[0] as HiveYoutubeVideo,
    );
  }

  @override
  void write(BinaryWriter writer, HiveWatchHistory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.video);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveWatchHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
