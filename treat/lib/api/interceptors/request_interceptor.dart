import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/shared/constants/storage.dart';

FutureOr<Request> requestInterceptor(request) async {
  // final token = StorageService.box.pull(StorageItems.accessToken);
  // request.headers['Content-Type'] = 'application/json';
  String path = request.url.path;
  Get.printInfo(info: 'requesting interceptor for $path');

  if (path == '/otp/phone' ||
      path == '/otp/email' ||
      path == '/otp/verify' ||
      path == '/initialtoken') {
  } else {
    Get.printInfo(info: 'requesting auth');

    final token =
        Get.find<SharedPreferences>().getString(StorageConstants.token);
    Get.printInfo(info: 'requesting auth $token');

    request.headers['Authorization'] = 'Bearer $token';
  }
  EasyLoading.show(status: 'loading...');
  return request;
}
