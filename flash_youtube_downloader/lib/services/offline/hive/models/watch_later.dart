import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'hive_youtube_video.dart';

// ignore: must_be_immutable
class HiveWatchLater extends Equatable with HiveObjectMixin {
  final HiveYoutubeVideo video;

  HiveWatchLater({
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

class HiveWatchLaterAdapter extends TypeAdapter<HiveWatchLater> {
  @override
  final int typeId = 1;

  @override
  HiveWatchLater read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveWatchLater(
      video: fields[0] as HiveYoutubeVideo,
    );
  }

  @override
  void write(BinaryWriter writer, HiveWatchLater obj) {
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
      other is HiveWatchLaterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
