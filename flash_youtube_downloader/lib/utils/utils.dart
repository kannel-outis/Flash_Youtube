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

    return ThemeData(
      brightness: brightness,
      fontFamily: "TT Firs Neue Regular",
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: blockWidth * 3.3,
        ),
        bodyText2: TextStyle(
          fontSize: blockWidth * 3.3,
        ),
        headline3: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: blockWidth * 7.5,
        ),
        subtitle1: TextStyle(
          fontSize: blockWidth * 2.2,
        ),
      ),
    );
  }
}
