import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:hive/hive.dart';

class HiveYoutubeVideo extends YoutubeVideo {
  final String? videoname;
  final String videoUrl;
  final int? views;
  final String? uploadDateText;
  final String? uploadername;
  final String? uploaderurl;
  final String? thumbnailurl;
  final Duration? videoDuration;
  final DateTime? uploaddate;

  HiveYoutubeVideo({
    this.thumbnailurl,
    this.uploadDateText,
    this.uploaddate,
    this.uploadername,
    this.uploaderurl,
    this.videoDuration,
    required this.videoUrl,
    this.videoname,
    this.views,
  }) : super(
          url: videoUrl,
          duration: videoDuration,
          textualUploadDate: uploadDateText,
          thumbnailUrl: thumbnailurl,
          uploaderName: uploadername,
          uploadDate: uploaddate,
          videoName: videoname,
          uploaderUrl: uploaderurl,
          viewCount: views,
        );
}

class HiveYoutubeVideoAdapter extends TypeAdapter<HiveYoutubeVideo> {
  @override
  final int typeId = 4;

  @override
  HiveYoutubeVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveYoutubeVideo(
      videoUrl: fields[0] as String,
      videoname: fields[1] as String?,
      uploadername: fields[2] as String?,
      uploaddate: fields[3] as DateTime?,
      uploadDateText: fields[4] as String?,
      uploaderurl: fields[5] as String?,
      videoDuration: fields[6] as Duration?,
      thumbnailurl: fields[7] as String?,
      views: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveYoutubeVideo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.videoUrl)
      ..writeByte(1)
      ..write(obj.videoname)
      ..writeByte(2)
      ..write(obj.uploadername)
      ..writeByte(3)
      ..write(obj.uploaddate)
      ..writeByte(4)
      ..write(obj.uploadDateText)
      ..writeByte(5)
      ..write(obj.uploaderurl)
      ..writeByte(6)
      ..write(obj.videoDuration)
      ..writeByte(7)
      ..write(obj.thumbnailurl)
      ..writeByte(8)
      ..write(obj.views);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveYoutubeVideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
