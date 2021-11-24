class StoreDetails {
  StoreDetails({
    required this.storeId,
    required this.storeName,
    required this.rating,
    required this.priceRange,
    required this.address1,
    required this.address2,
    required this.postcode,
    required this.city,
    required this.province,
    required this.contactNo,
    required this.website,
    required this.storeCategotyId,
    required this.storeCategoryName,
    required this.storeSpecialities,
    required this.storeSubCategoryId,
    required this.storeSubCategoryName,
    required this.location,
    required this.photos,
    required this.workingHours,
    required this.amneties,
    required this.loyaltyInfo,
    required this.pingedCoupons,
    required this.couponLayout,
    required this.storeCoupons,
    required this.isFavourite,
  });

  late final int storeId;
  late final String storeName;
  dynamic rating;
  late final int priceRange;
  late final String address1;
  late final String address2;
  late final String postcode;
  late final String city;
  late final String contactNo;
  late final String website;
  late final String province;
  late bool isFavourite;
  late final int storeCategotyId;
  late final String storeCategoryName;
  late final int storeSubCategoryId;
  late final String storeSubCategoryName;
  late final String couponLayout;
  late final List<String> menuAssetId;
  late final Location location;
  late final List<String> storeSpecialities;
  late final List<Photos> photos;
  late final List<WorkingHours> workingHours;
  late final List<Amneties> amneties;
  late final LoyaltyInfo loyaltyInfo;
  late final List<Coupons> pingedCoupons;
  late final List<Coupons> storeCoupons;

  StoreDetails.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    storeName = json['storeName'];
    rating = json['rating'];
    priceRange = json['priceRange'];
    address1 = json['address1'];
    address2 = json['address2'];
    postcode = json['postcode'];
    couponLayout = json['couponLayout'];
    city = json['city'];
    contactNo = json['contactNo'];
    website = json['website'] ?? '';
    province = json['province'];
    storeCategotyId = json['storeCategotyId'];
    storeCategoryName = json['storeCategoryName'];
    storeSubCategoryId = json['storeSubCategoryId'];
    storeSubCategoryName = json['storeSubCategoryName'];
    isFavourite = json['isFavourite'] ?? false;
    if (json['storeSpecialities'] != null)
      storeSpecialities =
          List.castFrom<dynamic, String>(json['storeSpecialities']);
    location = Location.fromJson(json['location']);
    try {
      if (json.containsKey('menuAssetId')) {
        menuAssetId = List.castFrom<dynamic, String>(json['menuAssetId'] ?? []);
      } else
        menuAssetId = List.castFrom<dynamic, String>(
            json['simpleCouponLayoutDetails']['menuAssetId'] ?? []);
    } catch (e) {
      menuAssetId = [];
      print(e);
    }

    photos = List.from(json['photos']).map((e) => Photos.fromJson(e)).toList();
    workingHours = List.from(json['workingHours'])
        .map((e) => WorkingHours.fromJson(e))
        .toList();
    amneties =
        List.from(json['amneties']).map((e) => Amneties.fromJson(e)).toList();
    if (json['loyaltyInfo'] != null)
      loyaltyInfo = LoyaltyInfo.fromJson(json['loyaltyInfo']);
    else
      loyaltyInfo = LoyaltyInfo(visitFreqInDays: 0, percDiscount: 0);
    pingedCoupons = List.from(json['pingedCoupons'])
        .map((e) => Coupons.fromJson(e))
        .toList();
    storeCoupons = List.from(json['storeCoupons'])
        .map((e) => Coupons.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['storeId'] = storeId;
    _data['storeName'] = storeName;
    _data['rating'] = rating;
    _data['priceRange'] = priceRange;
    _data['address1'] = address1;
    _data['address2'] = address2;
    _data['postcode'] = postcode;
    _data['city'] = city;
    _data['province'] = province;
    _data['storeCategotyId'] = storeCategotyId;
    _data['storeCategoryName'] = storeCategoryName;
    _data['storeSubCategoryId'] = storeSubCategoryId;
    _data['storeSubCategoryName'] = storeSubCategoryName;
    _data['location'] = location.toJson();
    _data['photos'] = photos.map((e) => e.toJson()).toList();
    _data['workingHours'] = workingHours.map((e) => e.toJson()).toList();
    _data['amneties'] = amneties.map((e) => e.toJson()).toList();
    _data['loyaltyInfo'] = loyaltyInfo.toJson();
    _data['pingedCoupons'] = pingedCoupons;
    _data['storeCoupons'] = storeCoupons.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });

  late final String latitude;
  late final String longitude;

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}

class Photos {
  Photos({
    required this.assetId,
    required this.priority,
    required this.isActive,
  });

  late final String assetId;
  late final int priority;
  late final bool isActive;

  Photos.fromJson(Map<String, dynamic> json) {
    assetId = json['assetId'];
    priority = json['priority'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['assetId'] = assetId;
    _data['priority'] = priority;
    _data['isActive'] = isActive;
    return _data;
  }
}

class WorkingHours {
  WorkingHours({
    required this.day,
    required this.closed,
    required this.timing,
  });

  late final String day;
  late final String closed;
  late final String timing;

  WorkingHours.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    closed = json['closed'];
    timing = json['timing'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['closed'] = closed;
    _data['timing'] = timing;
    return _data;
  }
}

class Amneties {
  Amneties({
    required this.id,
    required this.name,
    required this.assetId,
  });

  late final int id;
  late final String name;
  late final String assetId;

  Amneties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    assetId = json['assetId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['assetId'] = assetId;
    return _data;
  }
}

class LoyaltyInfo {
  LoyaltyInfo({
    this.loyaltyType,
    required this.visitFreqInDays,
    required this.percDiscount,
  });

  late final String? loyaltyType;
  late final int visitFreqInDays;
  late final int percDiscount;

  LoyaltyInfo.fromJson(Map<String, dynamic> json) {
    loyaltyType = json['loyaltyType'] ?? '';
    visitFreqInDays = json['visitFreqInDays'];
    percDiscount = json['percDiscount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loyaltyType'] = loyaltyType;
    _data['visitFreqInDays'] = visitFreqInDays;
    _data['percDiscount'] = percDiscount;
    return _data;
  }
}

class Coupons {
  Coupons({
    required this.couponId,
    required this.couponName,
    required this.couponDesc,
    required this.estimatedValue,
    required this.couponType,
    required this.groupName,
    required this.canRedeem,
    required this.canPing,
    required this.assetID,
    required this.remainingCount,
  });

  late final int couponId;
  late final String couponName;
  late final String couponDesc;
  late final String estimatedValue;
  late final String couponType;
  late final String groupName;
  late final bool canRedeem;
  late final bool canPing;
  late final String assetID;
  late final int remainingCount;

  Coupons.fromJson(Map<String, dynamic> json) {
    couponId = json['couponId'];
    couponName = json['couponName'];
    couponDesc = json['couponDesc'];
    estimatedValue = json['estimatedValue'];
    couponType = json['couponType'];
    groupName = json['groupName'];
    canRedeem = json['canRedeem'];
    canPing = json['canPing'];
    assetID = json['assetID'];
    remainingCount = json['remainingCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['couponId'] = couponId;
    _data['couponName'] = couponName;
    _data['couponDesc'] = couponDesc;
    _data['estimatedValue'] = estimatedValue;
    _data['couponType'] = couponType;
    _data['groupName'] = groupName;
    _data['canRedeem'] = canRedeem;
    _data['canPing'] = canPing;
    _data['assetID'] = assetID;
    _data['remainingCount'] = remainingCount;
    return _data;
  }
}
