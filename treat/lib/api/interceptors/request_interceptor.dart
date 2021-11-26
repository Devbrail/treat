import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(Request request) {
  EasyLoading.show(status: 'loading...');
  Future.delayed(Duration(seconds: 7)).then((value) => EasyLoading.dismiss());
  return request;
}
