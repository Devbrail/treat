class LoginResponse {
  bool? success;
  String? message;
  dynamic? errorCode;
  RespData? respData;

  LoginResponse({this.success, this.message, this.errorCode, this.respData});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.message = json["message"];
    this.errorCode = json["errorCode"];
    this.respData =
        json["respData"] == null ? null : RespData.fromJson(json["respData"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    data["message"] = this.message;
    data["errorCode"] = this.errorCode;
    if (this.respData != null) data["respData"] = this.respData?.toJson();
    return data;
  }
}

class RespData {
  String? accessToken;
  String? refreshToken;
  String? missingInfo;

  RespData({this.accessToken, this.refreshToken, this.missingInfo});

  RespData.fromJson(Map<String, dynamic> json) {
    this.accessToken = json["accessToken"];
    this.refreshToken = json["refreshToken"];
    this.missingInfo = json["missingInfo"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["accessToken"] = this.accessToken;
    data["refreshToken"] = this.refreshToken;
    data["missingInfo"] = this.missingInfo;
    return data;
  }
}
