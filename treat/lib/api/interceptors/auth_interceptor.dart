import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/shared/constants/storage.dart';

FutureOr<Request> authInterceptor(Request request) async {
  'auth interceptor  ${request.url.host}${request.url.path}'.printInfo();
  if (!kDebugMode)
  Sentry.captureMessage(
      'auth interceptor  ${request.url.host}${request.url.path}');
  if (ApiConstants.headerLess
      .where((element) => element.contains(request.url.path))
      .isEmpty) {
    final token =
        Get.find<SharedPreferences>().getString(StorageConstants.token);
    'Bearer $token'.toString().printInfo();
    request.headers['Authorization'] = 'Bearer $token';
  } else {
    'NO header need for ${request.url.path}'.printInfo();
  }

  return request;
}
