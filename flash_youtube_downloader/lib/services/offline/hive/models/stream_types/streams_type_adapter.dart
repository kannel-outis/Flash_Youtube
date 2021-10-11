import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:hive/hive.dart';

class VideoAudioStreamsAdapter extends TypeAdapter<VideoAudioStream> {
  @override
  final int typeId = 20;
  @override
  VideoAudioStream read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return VideoAudioStream(
      fields[0] as String, //url,
      fields[1] as String?, //codec,
      fields[2] as String?, //torrentUrl,
      fields[3] as int?, //bitrate,
      fields[4] as int?, //iTag,
      fields[5] as String, // format,
      fields[6] as Quality, //quality,
      fields[7] as int, //fps,
      fields[8] as String, //resolution,
      fields[9] as double, //height,
      fields[10] as double, //width,
      fields[11] as bool, //isVideoOnly,
    );
  }

  @override
  void write(BinaryWriter writer, VideoAudioStream obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.codec)
      ..writeByte(2)
      ..write(obj.torrentUrl)
      ..writeByte(3)
      ..write(obj.bitrate)
      ..writeByte(4)
      ..write(obj.iTag)
      ..writeByte(5)
      ..write(obj.format)
      ..writeByte(6)
      ..write(obj.quality)
      ..writeByte(7)
      ..write(obj.fps)
      ..writeByte(8)
      ..write(obj.resolution)
      ..writeByte(9)
      ..write(obj.height)
      ..writeByte(10)
      ..write(obj.width)
      ..writeByte(11)
      ..write(obj.isVideoOnly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoAudioStreamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoOnlyStreamsAdapter extends TypeAdapter<VideoOnlyStream> {
  @override
  final int typeId = 21;
  @override
  VideoOnlyStream read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return VideoOnlyStream(
      fields[0] as String, //url,
      fields[1] as String?, //codec,
      fields[2] as String?, //torrentUrl,
      fields[3] as int?, //bitrate,
      fields[4] as int?, //iTag,
      fields[5] as String, // format,
      fields[6] as Quality, //quality,
      fields[7] as int, //fps,
      fields[8] as String, //resolution,
      fields[9] as double, //height,
      fields[10] as double, //width,
      fields[11] as bool, //isVideoOnly,
    );
  }

  @override
  void write(BinaryWriter writer, VideoOnlyStream obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.codec)
      ..writeByte(2)
      ..write(obj.torrentUrl)
      ..writeByte(3)
      ..write(obj.bitrate)
      ..writeByte(4)
      ..write(obj.iTag)
      ..writeByte(5)
      ..write(obj.format)
      ..writeByte(6)
      ..write(obj.quality)
      ..writeByte(7)
      ..write(obj.fps)
      ..writeByte(8)
      ..write(obj.resolution)
      ..writeByte(9)
      ..write(obj.height)
      ..writeByte(10)
      ..write(obj.width)
      ..writeByte(11)
      ..write(obj.isVideoOnly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoOnlyStreamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AudioOnlyStreamAdapter extends TypeAdapter<AudioOnlyStream> {
  @override
  final int typeId = 22;
  @override
  AudioOnlyStream read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return AudioOnlyStream(
      fields[0] as String, //url,
      fields[1] as String?, //codec,
      fields[2] as String?, //torrentUrl,
      fields[3] as int?, //bitrate,
      fields[4] as int?, //averageBitrate,
      fields[5] as int?, // iTag,
      fields[6] as String, //format,
      fields[7] as Quality, //quality,
    );
  }

  @override
  void write(BinaryWriter writer, AudioOnlyStream obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.codec)
      ..writeByte(2)
      ..write(obj.torrentUrl)
      ..writeByte(3)
      ..write(obj.bitrate)
      ..writeByte(4)
      ..write(obj.avergaeBitrate)
      ..writeByte(5)
      ..write(obj.iTag)
      ..writeByte(6)
      ..write(obj.format)
      ..writeByte(7)
      ..write(obj.quality);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioOnlyStreamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
