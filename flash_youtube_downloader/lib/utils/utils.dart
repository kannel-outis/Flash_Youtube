import 'package:flutter/material.dart';

// ignore_for_file: avoid_classes_with_only_static_members

class Utils {
  static late double blockHeight;
  static late double blockWidth;

  static void getBlockWidthAndHeight(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      blockHeight = MediaQuery.of(context).size.height / 100;
      blockWidth = MediaQuery.of(context).size.width / 100;
    } else {
      blockHeight = MediaQuery.of(context).size.width / 100;
      blockWidth = MediaQuery.of(context).size.height / 100;
    }
  }

  static ThemeData themeData(BuildContext context, Brightness brightness) {
    getBlockWidthAndHeight(context);
    final isDarkTheme = brightness == Brightness.dark;
    print(blockWidth * 2.5);
    return ThemeData(
      brightness: brightness,
      fontFamily: "TT Firs Neue Regular",
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: blockWidth * 3.0 < 13 ? 13 : blockWidth * 3.0,
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: blockWidth * 2.5 < 9.0 ? 8.5 : blockWidth * 2.5,
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        headline3: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: blockWidth * 7.5,
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        subtitle1: TextStyle(
          fontSize: blockWidth * 2.2,
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  static String trimTime(String time) {
    if (time.isEmpty) return "00.00";
    final s = time.split(".");
    s.removeAt(s.length - 1);
    final y = s.join().split(":");
    if (int.tryParse(y.first) != null && int.tryParse(y.first)! > 0) {
      return y.join(":");
    } else {
      y.removeAt(0);
      return y.join(":");
    }
  }
}
