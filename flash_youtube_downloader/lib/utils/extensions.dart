extension ConvertView on String {
  String convertToViews() {
    if (!contains(".")) {
      final List<String> characters = split("").reversed.toList();
      for (var i = 0; i < characters.length; i++) {
        if (i % 4 == 0) {
          characters.insert(i, ",");
        }
      }

      var newConvert =
          characters.reversed.join().substring(0, characters.length - 1);
      final list = newConvert.split(",");
      if (list.length >= 3) {
        newConvert = "${list.first}.${list[1].substring(0, 1)}M";
      }
      return newConvert;
    } else {
      final List<String> char = split(".").toList();
      final List<String> characters = char[0].split("").reversed.toList();
      for (var i = 0; i < characters.length; i++) {
        if (i % 4 == 0) {
          characters.insert(i, ",");
        }
      }
      return characters.reversed.join().substring(0, characters.length - 1) +
          (".${char[1]}");
    }
  }
}
