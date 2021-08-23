class Utils {
  static String retrieveTime(String stringTime) {
    var split = stringTime.split("T");
    return split[0];
  }
}
