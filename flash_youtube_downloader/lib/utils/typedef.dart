import 'dart:io';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';

typedef DownloadCompletedCallback = void Function(
    File, File?, ContentSize, DownloadState);
typedef DownloadProgressCallback = void Function(String, DownloadState);
typedef DownloadCancelCallback = void Function(ContentSize, DownloadState);
typedef DownloadFailedCallback = void Function(String, DownloadState);
