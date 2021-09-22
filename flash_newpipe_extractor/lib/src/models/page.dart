class Page {
  final String? id;
  final String url;
  final int? pageNumber;

  const Page({this.id, required this.url, this.pageNumber});
  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(
      url: map["url"],
      id: map["id"],
    );
  }
}
