import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

FutureOr<Request> requestInterceptor(Request request) {
  EasyLoading.show(status: 'loading...');
   'auth interceptor ${request.method}  ${request.url.host}${request.url.path}'.printInfo();
  if (kReleaseMode)
    Sentry.captureMessage(
        'auth interceptor  ${request.method}  ${request.url.host}${request.url.path}');
  Future.delayed(Duration(seconds: 7)).then((value) => EasyLoading.dismiss());
  return request;
}
