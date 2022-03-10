import 'package:intl/intl.dart';

class SavingList {
  bool? success;
  String? message;
  String? errorCode;
  RespData? respData;

  SavingList({this.success, this.message, this.errorCode, this.respData});

  SavingList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errorCode = json['errorCode'];
    respData = json['respData'] != null
        ? new RespData.fromJson(json['respData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.respData != null) {
      data['respData'] = this.respData!.toJson();
    }
    return data;
  }
}

class RespData {
  List<SavingsByStores>? savingsByStores;

  RespData({this.savingsByStores});

  RespData.fromJson(Map<String, dynamic> json) {
    if (json['savingsByStores'] != null) {
      savingsByStores = <SavingsByStores>[];
      json['savingsByStores'].forEach((v) {
        savingsByStores!.add(new SavingsByStores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.savingsByStores != null) {
      data['savingsByStores'] =
          this.savingsByStores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SavingsByStores {
  String? storeName;
  String? storeCategory;
  String? logoAssetUrl;
  String? storeLocation;
  num? savedAmount;
  String? redemptionDate;
  String? referenceCode;

  SavingsByStores(
      {this.storeName,
        this.storeCategory,
        this.logoAssetUrl,
        this.storeLocation,
        this.savedAmount,
        this.redemptionDate,
        this.referenceCode});

  SavingsByStores.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName']??'';
    storeCategory = json['storeCategory']??'';
    logoAssetUrl = json['logoAssetUrl'];
    storeLocation = json['storeLocation']??'';
    savedAmount = json['savedAmount']??0;
    if(json['redemptionDate']!=null) {
       var format=DateTime.parse(json['redemptionDate']);
      var outputFormat = DateFormat('MM/dd/yy');
      redemptionDate = outputFormat.format(format);
    }
    referenceCode = json['referenceCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeName'] = this.storeName;
    data['storeCategory'] = this.storeCategory;
    data['logoAssetUrl'] = this.logoAssetUrl;
    data['storeLocation'] = this.storeLocation;
    data['savedAmount'] = this.savedAmount;
    data['redemptionDate'] = this.redemptionDate;
    data['referenceCode'] = this.referenceCode;
    return data;
  }
}
