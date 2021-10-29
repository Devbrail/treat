import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/shared/constants/storage.dart';

FutureOr<Request> authInterceptor(Request request) async {
  'auth interceptor  ${request.url.host}${request.url.path}'.printInfo();
  if (ApiConstants.headerLess
      .where((element) => element.contains(request.url.path))
      .isEmpty) {
    final token =
        Get.find<SharedPreferences>().getString(StorageConstants.token);
    Get.printInfo(info: 'requesting auth $token');

    request.headers['Authorization'] = 'Bearer $token';
  } else {
    'NO header need for ${request.url.path}'.printInfo();
  }

  return request;
}
