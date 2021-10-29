import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared.dart';

class Utils {
  static setStatusBarColor({Color color = ColorConstants.lightViolet}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ColorConstants.black, // navigation bar color
      statusBarColor: color, // status bar color
    ));
  }

  static SharedPreferences sharedPreferences = Get.find<SharedPreferences>();

  static bool get isGuest =>
      sharedPreferences.getString(StorageConstants.loginTye) ==
      StorageConstants.guest;

  static saveLoginType(String type) {
    sharedPreferences.setString(StorageConstants.loginTye, type);
  }
}

/// zom zom arbic cafe
/*https://treatstorage.blob.core.windows.net/assets/000/000/000000425054c21.png?sv=2020-08-04&se=2021-10-27T17%3A20%3A06Z&sr=c&sp=r&sig=5OYjRxSwW8OUG3TP4zpPG%2B9RzjJhqDn9NzhZtqZIfJA%3D"*/
