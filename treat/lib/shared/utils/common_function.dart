import 'dart:ui';

import 'package:flutter/services.dart';

import '../shared.dart';

class Utils {
  static setStatusBarColor({Color color = ColorConstants.lightViolet}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ColorConstants.black, // navigation bar color
      statusBarColor: color, // status bar color
    ));
  }
}
