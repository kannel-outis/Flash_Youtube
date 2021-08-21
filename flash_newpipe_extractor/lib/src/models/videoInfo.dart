class YoutubeVideo {
  final String? videoName;
  final String? url;
  final int? viewCount;
  final String? textualUploadDate;
  final String? uploaderName;
  final String? uploaderUrl;
  final String? thumbnailUrl;
  final Duration? duration;
  final DateTime? uploadDate;
  final bool? isUploaderVerified;

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
    String _retrieveTime(String stringTime) {
      var split = stringTime.split("T");
      return split[0];
    }

    return YoutubeVideo(
      url: map["url"],
      uploaderUrl: map["uploaderUrl"],
      isUploaderVerified: map["isUploaderVerified"],
      textualUploadDate: map["textualUploadDate"],
      uploadDate: DateTime.tryParse(
        _retrieveTime(
          map["textualUploadDate"],
        ),
      ),
      duration: Duration(seconds: map["duration"]),
      thumbnailUrl: map["thumbnailUrl"],
      uploaderName: map["uploaderName"],
      videoName: map["videoName"],
      viewCount: map["viewCount"],
    );
  }
}
