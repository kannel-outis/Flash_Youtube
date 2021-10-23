import 'package:flash_newpipe_extractor/src/models/stream/streams.dart';

class StreamOfType<T extends Streams> {
  final T? streams;

  StreamOfType(this.streams);
}
