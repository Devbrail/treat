import 'package:treat/shared/constants/common.dart';

import '../entity_factory.dart';

class BaseResponse<T> {
  late int code;
  late String message;
  late T? data;
  late List<T> listData = [];

  BaseResponse(this.code, this.message, this.data);

  BaseResponse.fromJson(Map<String, dynamic>? json, int statusCode) {
    code = statusCode;
    if (statusCode == 200) {
      message = CommonConstants.successMessage;
      if (json!.containsKey(CommonConstants.responseData)) {
        if (json[CommonConstants.responseData] is List) {
          (json[CommonConstants.responseData] as List).forEach((item) {
            if (T.toString() == "String") {
              listData.add(item.toString() as T);
            } else {
              listData.add(EntityFactory.generateOBJ<T>(item));
            }
          });
        } else {
          if (T.toString() == "String") {
            data = json[CommonConstants.responseData].toString() as T;
          } else if (T.toString() == "Map<dynamic, dynamic>") {
            data = json[CommonConstants.responseData] as T;
          } else {
            data = EntityFactory.generateOBJ<T>(
                json[CommonConstants.responseData]);
          }
        }
      } else
        data = EntityFactory.generateOBJ(json);
    } else if (statusCode == 401) {
      data = -1 as T;
    }
  }

  bool hasValidData(json) {
    return (json as Map<dynamic, dynamic>).length > 0 ? true : false;
  }
}
