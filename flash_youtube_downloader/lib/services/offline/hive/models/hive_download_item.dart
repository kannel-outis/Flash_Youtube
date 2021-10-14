import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_youtube_video.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:hive/hive.dart';

class HiveDownloadItem extends HiveObject {
  final List<String> streamLinks;
  final HiveYoutubeVideo video;
  final VideoAudioStream? videoAudioStream;
  final VideoOnlyStream? videoOnlyStream;
  final AudioOnlyStream? audioOnlyStream;
  final String downloaderId;
  final int totalSize;
  String? finalProcessedVideoPath;
  List<String?> downloadPaths;
  List<String> downloadLinks;
  int downloadedBytes;
  DownloadState downloadState;
  String progress;
  HiveDownloadItem({
    required this.streamLinks,
    required this.totalSize,
    required this.video,
    required this.downloaderId,
    required this.audioOnlyStream,
    required this.videoAudioStream,
    required this.videoOnlyStream,
    this.finalProcessedVideoPath,
    this.downloadPaths = const [],
    this.downloadLinks = const [],
    this.downloadState = DownloadState.notStarted,
    this.downloadedBytes = 0,
    this.progress = "0%",
  });
}

class HiveDownloadItemAdapter extends TypeAdapter<HiveDownloadItem> {
  @override
  final int typeId = 5;

  @override
  HiveDownloadItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDownloadItem(
      streamLinks: (fields[0] as List).cast<String>(),
      downloadPaths: (fields[1] as List).cast<String?>(),
      downloadLinks: (fields[2] as List).cast<String>(),
      downloadedBytes: fields[3] as int,
      downloadState: fields[4] as DownloadState,
      downloaderId: fields[5] as String,
      progress: fields[6] as String,
      video: fields[7] as HiveYoutubeVideo,
      finalProcessedVideoPath: fields[8] as String?,
      audioOnlyStream: fields[9] as AudioOnlyStream?,
      videoAudioStream: fields[10] as VideoAudioStream?,
      videoOnlyStream: fields[11] as VideoOnlyStream?,
      totalSize: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDownloadItem obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.streamLinks)
      ..writeByte(1)
      ..write(obj.downloadPaths)
      ..writeByte(2)
      ..write(obj.downloadLinks)
      ..writeByte(3)
      ..write(obj.downloadedBytes)
      ..writeByte(4)
      ..write(obj.downloadState)
      ..writeByte(5)
      ..write(obj.downloaderId)
      ..writeByte(6)
      ..write(obj.progress)
      ..writeByte(7)
      ..write(obj.video)
      ..writeByte(8)
      ..write(obj.finalProcessedVideoPath)
      ..writeByte(9)
      ..write(obj.audioOnlyStream)
      ..writeByte(10)
      ..write(obj.videoAudioStream)
      ..writeByte(11)
      ..write(obj.videoOnlyStream)
      ..writeByte(12)
      ..write(obj.totalSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDownloadItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DownloadStateAdapter extends TypeAdapter<DownloadState> {
  @override
  final int typeId = 6;

  @override
  DownloadState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DownloadState.canceled;
      case 1:
        return DownloadState.completed;
      case 2:
        return DownloadState.paused;
      case 3:
        return DownloadState.notStarted;
      case 4:
        return DownloadState.failed;
      default:
        return DownloadState.downloading;
    }
  }

  @override
  void write(BinaryWriter writer, DownloadState obj) {
    switch (obj) {
      case DownloadState.canceled:
        writer.writeByte(0);
        break;
      case DownloadState.completed:
        writer.writeByte(1);
        break;
      case DownloadState.paused:
        writer.writeByte(2);
        break;
      case DownloadState.notStarted:
        writer.writeByte(3);
        break;
      case DownloadState.failed:
        writer.writeByte(4);
        break;
      case DownloadState.downloading:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
