class Utils {
  static String changeToRealPath(String rawPath) {
    if (!rawPath.contains(":")) return rawPath;
    const internal = "/storage/emulated/0/";
    final splitRawPath = rawPath.split(":");
    final storagelocation = splitRawPath[0].split("/");
    if (storagelocation.last == "primary") {
      return "$internal${splitRawPath[1]}";
    } else {
      return "/storage/${storagelocation.last}/${splitRawPath[1]}";
    }
  }
}
