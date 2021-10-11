import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:hive/hive.dart';

class QualityAdapter extends TypeAdapter<Quality> {
  @override
  final int typeId = 19;

  @override
  Quality read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Quality.hd1080;
      case 1:
        return Quality.hd2k;
      case 2:
        return Quality.hd720;
      case 3:
        return Quality.large;
      case 4:
        return Quality.medium;
      case 5:
        return Quality.small;
      default:
        return Quality.tiny;
    }
  }

  @override
  void write(BinaryWriter writer, Quality obj) {
    switch (obj) {
      case Quality.hd1080:
        writer.writeByte(0);
        break;
      case Quality.hd2k:
        writer.writeByte(1);
        break;
      case Quality.hd720:
        writer.writeByte(2);
        break;
      case Quality.large:
        writer.writeByte(3);
        break;
      case Quality.medium:
        writer.writeByte(4);
        break;
      case Quality.small:
        writer.writeByte(5);
        break;
      case Quality.tiny:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QualityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
