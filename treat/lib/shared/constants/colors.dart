import 'package:flutter/material.dart';

class ColorConstants {
  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = hexToColor('#22DDA6');
  static const Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static const Color lightGray = const Color(0xFFF6F6F6);
  static const Color darkGray = const Color(0xFF9F9F9F);
  static const Color white = const Color(0xFFFFFFFF);

  static const Color yellow = const Color(0xFFF4C500);
  static const Color lightYellow = const Color(0xFFFFED6C);
  static const Color violet = const Color(0xFFC36BFF);
  static const Color lightViolet = const Color(0xFFD89FFF);
  static const Color black = const Color(0xFF585858);
  static const Color green = const Color(0xFFADEFFF);
  static const Color whiteGrey = const Color(0xFFF4F4F4);
  static const Color textFieldBackround = const Color(0xFFbdc6cf);
  static const Color pinInputBackround = const Color(0xFFEAEAEA);

  static const Color textColorBlack = const Color(0xFF707070);
  static const Color skipButtonBoxColor = const Color(0xFFF5E8FF);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
