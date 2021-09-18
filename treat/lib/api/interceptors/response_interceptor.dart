import 'dart:async';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:treat/models/models.dart';
import 'package:treat/shared/shared.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  EasyLoading.dismiss();

  if (response.statusCode != 200) {
    handleErrorStatus(response);
    return;
  } else
    Get.printInfo(
        info: '${response.request!.url.path}\n${response.bodyString}');
  return response;
}

void handleErrorStatus(Response response) {
  Get.printInfo(info: 'response');
  Get.printInfo(info: response.bodyString!);
  Get.printInfo(info: response.statusCode.toString());
  switch (response.statusCode) {
    case 400:
      final message = ErrorResponse.fromJson(response.body);
      CommonWidget.toast(message.error);
      break;
    case 401:
      CommonWidget.toast('Authorization Failed');
      break;
    default:
      CommonWidget.toast(response.statusText ?? 'Server Error!');
      break;
  }

  return;
}
