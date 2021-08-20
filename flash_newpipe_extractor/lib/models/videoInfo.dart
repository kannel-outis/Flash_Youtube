class YoutubeVideo {
  final String? videoName;
  final String? url;
  final int? viewCount;
  final DateTime? textualUploadDate;
  final String? uploaderName;
  final String? uploaderUrl;
  final String? thumbnailUrl;
  final Duration? duration;
  final DateTime? uploadDate;
  final String? isUploaderVerified;

  const YoutubeVideo({
    this.videoName,
    this.url,
    this.viewCount,
    this.textualUploadDate,
    this.uploaderName,
    this.uploaderUrl,
    this.thumbnailUrl,
    this.duration,
    this.uploadDate,
    this.isUploaderVerified,
  });

  factory YoutubeVideo.fromMap(Map<String, dynamic> map) {
    return YoutubeVideo();
  }
}
