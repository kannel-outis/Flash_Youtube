import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:hive/hive.dart';

class HiveDownloadItem extends HiveObject {
  final List<String> streamLinks;
  final String downloadPath;
  List<String> downloadLinks;
  int downloadedBytes;
  DownloadState downloadState;
  HiveDownloadItem({
    required this.streamLinks,
    required this.downloadPath,
    this.downloadLinks = const [],
    this.downloadState = DownloadState.notStarted,
    this.downloadedBytes = 0,
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
      downloadPath: fields[1] as String,
      downloadLinks: (fields[2] as List).cast<String>(),
      downloadedBytes: fields[3] as int,
      downloadState: fields[4] as DownloadState,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDownloadItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.streamLinks)
      ..writeByte(1)
      ..write(obj.downloadPath)
      ..writeByte(2)
      ..write(obj.downloadLinks)
      ..writeByte(3)
      ..write(obj.downloadedBytes)
      ..writeByte(4)
      ..write(obj.downloadState);
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
