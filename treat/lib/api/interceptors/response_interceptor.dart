import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:treat/models/models.dart';
import 'package:treat/modules/auth/auth_controller.dart';
import 'package:treat/shared/shared.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  Get.printInfo(info: 'response ${request.url.path}');
  EasyLoading.dismiss();

  if (response.statusCode != 200) {
    handleErrorStatus(response);
  } else
    Get.printInfo(
        info: '${response.request!.url.path}\n${response.bodyString}');
  return response;
}

void handleErrorStatus(Response response) {
  Get.printInfo(info: response.statusCode.toString() + " Status code");
  switch (response.statusCode) {
    case 400:
      final message = ErrorResponse.fromJson(response.body);
      CommonWidget.toast(message.error);
      break;
    case 401:
      // CommonWidget.toast('Authorization Failed');
      AuthController controller =
          Get.put(AuthController(apiRepository: Get.find()));

      // controller.fetchAuthToken();
      break;
    case 500:
      AuthController controller =
          Get.put(AuthController(apiRepository: Get.find()));

      controller.fetchAuthToken();

      CommonWidget.toast('Internal Server error');

      break;
    default:
      CommonWidget.toast(response.statusText ?? 'Server Error!');
      break;
  }

  return;
}
