class CommentInfo {
  final bool commentsDisabled;
  final String? commentID;
  final String? commentText;
  final bool? isHeartedByUploader;
  final bool? isPinned;
  final int? likeCount;
  final String? textualUploadDate;
  final String? uploaderAvatarUrl;
  final String? uploaderName;
  final String? uploaderUrl;

  const CommentInfo({
    this.commentsDisabled = false,
    this.commentID,
    this.commentText,
    this.isHeartedByUploader,
    this.isPinned,
    this.likeCount,
    this.textualUploadDate,
    this.uploaderAvatarUrl,
    this.uploaderName,
    this.uploaderUrl,
  });

  factory CommentInfo.fromMap(Map<String, dynamic> map) {
    return CommentInfo(
        commentID: map["commentId"],
        commentText: map["commentText"],
        // commentsDisabled: map["disabled"],
        isHeartedByUploader: map["isHeartedByUploader"],
        isPinned: map["isPinned"],
        likeCount: map["likeCount"],
        textualUploadDate: map["textualUploadDate"],
        uploaderAvatarUrl: map["uploaderAvatarUrl"],
        uploaderName: map["uploaderName"],
        uploaderUrl: map["uploaderUrl"]);
  }
}
