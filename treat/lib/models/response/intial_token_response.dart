class IntialTokenResponse {
  bool? success;
  String? message;
  int? errorCode;
  RespData? respData;

  IntialTokenResponse(
      {this.success, this.message, this.errorCode, this.respData});

  IntialTokenResponse.fromJson(Map<String, dynamic> json) {
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
  String? initialToken;

  RespData({this.initialToken});

  RespData.fromJson(Map<String, dynamic> json) {
    this.initialToken = json["initialToken"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["initialToken"] = this.initialToken;
    return data;
  }
}
