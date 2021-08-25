class Utils {
  static String retrieveTime(String stringTime) {
    var split = stringTime.split("T");
    return split[0];
  }

  static getIdFromUrl(String url) {
    final regex = RegExp(
        r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*');
    return regex.firstMatch(url)?.group(1);
  }
}
