extension ConvertView on String {
  // ignore: avoid_positional_boolean_parameters
  String convertToViews([bool shorten = true, bool rawThousands = true]) {
    if (!contains(".")) {
      if (this == "-1") {
        return "0";
      }
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
      if (!shorten) {
        return characters.reversed.join().substring(0, characters.length - 1);
      }
      if (!rawThousands && list.length == 2) {
        newConvert = "${list.first}K";
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
      if ((characters.length - 1).isNegative) {
        return characters.reversed.join().substring(0, characters.length) +
            (".${char[1]}");
      }
      return characters.reversed.join().substring(0, characters.length - 1) +
          (".${char[1]}");
    }
  }
}
