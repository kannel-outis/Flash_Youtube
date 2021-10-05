import 'dart:io';

import 'package:flash_newpipe_extractor/src/models/content_size.dart';

typedef DownloadCompletedCallBack = void Function(File, ContentSize);
typedef DownloadProgressCallBack = void Function(String);
typedef DownloadErrorCallBack = void Function(String);
