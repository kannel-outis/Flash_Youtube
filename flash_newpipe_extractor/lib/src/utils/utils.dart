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

  static Map<String, Map<int, Map<String, dynamic>>> convertToType(
      dynamic value) {
    return Map<String, dynamic>.from(value).map(
      (key, value) => MapEntry(
        key,
        Map<int, dynamic>.from(value).map(
          (key, value) => MapEntry(
            key,
            Map<String, dynamic>.from(value),
          ),
        ),
      ),
    );
  }

  static Map<int, Map<String, dynamic>> convertToMapType(dynamic value) {
    return Map<int, dynamic>.from(value).map(
      (key, value) => MapEntry(
        key,
        Map<String, dynamic>.from(value),
      ),
    );
  }
}
