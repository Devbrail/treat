class Ping {
  List<PingSummaries>? pingSummaries;

  Ping({this.pingSummaries});

  Ping.fromJson(Map<String, dynamic> json) {
    if (json['pingSummaries'] != null) {
      pingSummaries = <PingSummaries>[];
      json['pingSummaries'].forEach((v) {
        pingSummaries!.add(new PingSummaries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pingSummaries != null) {
      data['pingSummaries'] =
          this.pingSummaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PingSummaries {
  String? acceptedDate;
  String? pingedBy;
  StoreDetails? storeDetails;
  CouponDetails? couponDetails;

  PingSummaries(
      {this.acceptedDate,
      this.pingedBy,
      this.storeDetails,
      this.couponDetails});

  PingSummaries.fromJson(Map<String, dynamic> json) {
    acceptedDate = json['acceptedDate'];
    pingedBy = json['pingedBy'];
    storeDetails = json['storeDetails'] != null
        ? new StoreDetails.fromJson(json['storeDetails'])
        : null;
    couponDetails = json['couponDetails'] != null
        ? new CouponDetails.fromJson(json['couponDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acceptedDate'] = this.acceptedDate;
    data['pingedBy'] = this.pingedBy;
    if (this.storeDetails != null) {
      data['storeDetails'] = this.storeDetails!.toJson();
    }
    if (this.couponDetails != null) {
      data['couponDetails'] = this.couponDetails!.toJson();
    }
    return data;
  }
}

class StoreDetails {
  int? storeId;
  String? storeName;
  String? couponLayout;
  String? category;

  StoreDetails({
    this.storeId,
    this.storeName,
    this.couponLayout,
    this.category,
  });

  StoreDetails.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    storeName = json['storeName'];
    couponLayout = json['couponLayout'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    data['category'] = this.category;
    return data;
  }
}

class CouponDetails {
  int? couponId;
  String? status;
  String? couponTitle;
  String? couponDescription;
  String? couponAssetId;
  bool? canRedeem;
  String? expiryDate;

  CouponDetails(
      {this.couponId,
      this.status,
      this.couponTitle,
      this.canRedeem,
      this.couponDescription,
      this.expiryDate,
      this.couponAssetId});

  CouponDetails.fromJson(Map<String, dynamic> json) {
    couponId = json['couponId'];
    status = json['status'];
    couponTitle = json['couponTitle'];
    couponDescription = json['couponDescription'];
    canRedeem = json['canRedeem'];
    expiryDate = json['expiryDate'];
    couponAssetId = json['couponAssetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponId'] = this.couponId;
    data['status'] = this.status;
    data['couponTitle'] = this.couponTitle;
    data['couponDescription'] = this.couponDescription;
    data['couponAssetId'] = this.couponAssetId;
    return data;
  }
}
