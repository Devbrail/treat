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
  EasyLoading.dismiss();
  Get.printInfo(info: 'response ${response.statusCode} ${request.url.path}');

  handleErrorStatus(response);

    Get.printInfo(
        info: '${response.request!.url.path}\n${response.bodyString}');
  return response;
}

void handleErrorStatus(Response response) {
  Get.printInfo(info: response.statusCode.toString() + " Status code");
  switch (response.statusCode) {
    case 200:
      if (!response.body['success'])
        error.forEach((element) {
          'fdfkj ${element['code']} ${response.body['errorCode']}'.printInfo();
          if (element['code'] == response.body['errorCode'])
            CommonWidget.toast(element['message'] ?? '');
        });
      break;
    case 400:
      final message = response.body is String
          ? response.body
          : ErrorResponse.fromJson(response.body);
      CommonWidget.toast(message?.error! ?? message ?? '');
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
      // CommonWidget.toast(response.statusText ?? 'Server Error!');
      break;
  }

  return;
}

var error = [
  {"code": "TREATAPP_SUCCESS", "message": "Successful"},
  {
    "code": "TREATAPP_MANDATORY_DATA_MISSING_INVALID_INPUT",
    "message": "Mandatory field missing or invalid input. Please review"
  },
  {
    "code": "TREATAPP_OPERATION_FAILED",
    "message": "Intented action failed due to error"
  },
  {"code": "TREATAPP_NO_DATA_FOUND", "message": "Data not found"},
  {"code": "TREATAPP_DATA_DUPLICATE", "message": "Duplicate data noticed"},
  {
    "code": "TREATAPP_NO_JOB_TO_EXECUTE",
    "message": "Cannot execute as no jobs are allocated"
  },
  {"code": "TREATAPP_INITIAL_TOKEN_NOTVALID", "message": "Invalid token"},
  {
    "code": "TREAT_INITIALTOKEN_REQUEST_EXCEEDED_FROM_SINGLE_IP",
    "message": "TREAT_INITIALTOKEN_REQUEST_EXCEEDED_FROM_SINGLE_IP"
  },
  {
    "code": "TREAT_FAILED_TO_INITIATE_SMS_EMAIL_COMMUNICATION",
    "message": "TREAT_FAILED_TO_INITIATE_SMS_EMAIL_COMMUNICATION"
  },
  {
    "code": "TREAT_OTP_NOT_FOUND_OR_ALREADY_VALIDATED",
    "message": "TREAT_OTP_NOT_FOUND_OR_ALREADY_VALIDATED"
  },
  {"code": "TREAT_INVALID_OTP", "message": "TREAT_INVALID_OTP"}
];
