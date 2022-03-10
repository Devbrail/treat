import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:intl/intl.dart';
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

  static bool isAdvanced(String couponLayout) =>
      couponLayout == CommonConstants.ADVANCED;

  static saveLoginType(String type) {
    sharedPreferences.setString(StorageConstants.loginTye, type);
  }

  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    return '${placemarks.first.name!} ,${placemarks.last.street!},${placemarks.first.postalCode!}';
  }

  static Future<Location> locationFromAddresses(String address) async {
    return (await locationFromAddress(address)).first;
  }

  static IconData addressType(String addressType) {
    addressType.printInfo();
    switch (addressType) {
      case 'Home':
        return CupertinoIcons.home;
      case 'Office':
        return CupertinoIcons.briefcase;
      default:
        return CupertinoIcons.flag;
    }
  }

  static List<Map> getMonthsInYear() {
    DateFormat dateFormat = DateFormat("MMM");
    DateTime userCreatedDate = DateTime.now();

    return List.generate(12, (int index) {
      final date = DateTime(userCreatedDate.year, index + 1);
      return {
        'title': dateFormat.format(date),
        'id': date.month,
        'isSelected': DateTime.now().month == date.month ? true : false
      };
    });
  }
}
List icons = [
  {'icon': '$IMAGE_PATH/home_loc.png', 'flg': true},
  {'icon': '$IMAGE_PATH/briefcase_loc.png', 'flg': false},
  {'icon': '$IMAGE_PATH/heart_loc.png', 'flg': false},
  {'icon': '$IMAGE_PATH/flag_loc.png', 'flg': false},
  {'icon': '$IMAGE_PATH/star_loc.png', 'flg': false},
];
