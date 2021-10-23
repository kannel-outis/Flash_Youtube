import 'dart:typed_data';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter/material.dart';

// ignore_for_file: avoid_classes_with_only_static_members

class Utils {
  static late double blockHeight;
  static late double blockWidth;
  static late Orientation orientation;
  static late bool isDarkTheme;

  static final navigationKey = GlobalKey<NavigatorState>();

  static void getBlockWidthAndHeight(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      blockHeight = MediaQuery.of(context).size.height / 100;
      blockWidth = MediaQuery.of(context).size.width / 100;
    } else {
      blockHeight = MediaQuery.of(context).size.width / 100;
      blockWidth = MediaQuery.of(context).size.height / 100;
    }
  }

  static Color placeHolderColor = const Color(0xFF212121);
  static Color containerLabelColor = const Color(0xFF3d3d3d);
  static Color containerLabelColorLight = const Color(0xFFaaaaaa);

  static ThemeData themeData(BuildContext context, Brightness brightness) {
    getBlockWidthAndHeight(context);
    isDarkTheme = brightness == Brightness.dark;
    final theme = Theme.of(context);
    return ThemeData(
      popupMenuTheme: PopupMenuThemeData(
        color: isDarkTheme
            ? const Color(0xFF181818)
            : theme.scaffoldBackgroundColor,
      ),
      dialogBackgroundColor:
          isDarkTheme ? const Color(0xFF181818) : theme.scaffoldBackgroundColor,
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xFF181818) : theme.scaffoldBackgroundColor,
      brightness: brightness,
      fontFamily: "TT Firs Neue Regular",
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: blockWidth * 2.5 < 13 ? 17 : blockWidth * 2.5,
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: blockWidth * 2.0 < 9.0 ? 11.5 : blockWidth * 2.0,
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
      primaryIconTheme: IconThemeData(size: blockWidth * 3),
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDarkTheme
            ? const Color(0xFF181818)
            : theme.scaffoldBackgroundColor,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: isDarkTheme
            ? const Color(0xFF181818)
            : theme.scaffoldBackgroundColor,
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

  static const dummyPictureUrl =
      "http://dreamvilla.life/wp-content/uploads/2017/07/dummy-profile-pic-300x300.png";

  static final Uint8List transparentImage = Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);

  static ContentSize bytesToContentSize(int bytes) {
    return ContentSize(bytes: bytes);
  }
}
