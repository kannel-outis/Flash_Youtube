import 'dart:io';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';

typedef DownloadCompletedCallback = void Function(File, File?, ContentSize);
typedef DownloadProgressCallback = void Function(String);
typedef DownloadCancelCallback = void Function(ContentSize);
typedef DownloadFailedCallback = void Function(String);
