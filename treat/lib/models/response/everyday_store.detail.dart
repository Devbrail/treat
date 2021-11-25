class EveryDayStore {
  EveryDayStore({
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
    required this.storeSpecialities,
    required this.storeCategotyId,
    required this.storeCategoryName,
    required this.storeSubCategoryId,
    required this.storeSubCategoryName,
    required this.location,
    required this.categoryData,
    required this.photos,
    required this.workingHours,
    required this.amneties,
    required this.loyaltyInfo,
    required this.pingedCoupons,
    required this.storeCoupons,
  });

  late final int storeId;
  late final String storeName;
  late final double rating;
  late final int priceRange;
  late final String address1;
  late final String address2;
  late final String postcode;
  late final String city;
  late final String province;
  late final String contactNo;
  late final String website;
  late final List<dynamic> storeSpecialities;
  late final int storeCategotyId;
  late final String storeCategoryName;
  late final int storeSubCategoryId;
  late final String storeSubCategoryName;
  late final String couponLayout;
  late final Location location;
  late bool isFavourite;
  late final CategoryData categoryData;
  late final List<Photos> photos;
  late final List<WorkingHours> workingHours;
  late final List<Amneties> amneties;
  late final LoyaltyInfo loyaltyInfo;
  late final List<dynamic> pingedCoupons;
  late final List<StoreCoupons> storeCoupons;
  late final List<String> menuAssetId;

  EveryDayStore.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    storeName = json['storeName'];
    rating = json['rating'];
    priceRange = json['priceRange'];
    address1 = json['address1'] ?? '';
    address2 = json['address2'] ?? '';
    postcode = json['postcode'];
    city = json['city'];
    couponLayout = json['couponLayout'];
    province = json['province'];
    contactNo = json['contactNo'] ?? '';
    website = json['website'] ?? '';
    storeSpecialities =
        List.castFrom<dynamic, dynamic>(json['storeSpecialities']);
    storeCategotyId = json['storeCategotyId'];
    storeCategoryName = json['storeCategoryName'];
    isFavourite = json['isFavourite'];
    storeSubCategoryId = json['storeSubCategoryId'];
    try {
      if (json['simpleCouponLayoutDetails']['menuAssetId'] != null)
        menuAssetId = List.castFrom<dynamic, String>(
            json['simpleCouponLayoutDetails']['menuAssetId']);
      else
        menuAssetId = [];
    } catch (e) {
      menuAssetId = [];

      print(e);
    }
    storeSubCategoryName = json['storeSubCategoryName'];
    location = Location.fromJson(json['location']);
    if (json['advancedCouponLayoutDetails'] != null)
      categoryData = CategoryData.fromJson(json['advancedCouponLayoutDetails']);
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
    pingedCoupons = List.castFrom<dynamic, dynamic>(json['pingedCoupons']);
    storeCoupons = List.from(json['storeCoupons'])
        .map((e) => StoreCoupons.fromJson(e))
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
    _data['contactNo'] = contactNo;
    _data['website'] = website;
    _data['storeSpecialities'] = storeSpecialities;
    _data['menuAssetId'] = menuAssetId;
    // _data['simpleCouponLayoutDetails']['menuAssetId'] =
    //     menuAssetId.isNotEmpty ? menuAssetId.asMap() : [];
    _data['couponLayout'] = couponLayout;
    _data['storeCategotyId'] = storeCategotyId;
    _data['storeCategoryName'] = storeCategoryName;
    _data['storeSubCategoryId'] = storeSubCategoryId;
    _data['storeSubCategoryName'] = storeSubCategoryName;
    _data['location'] = location.toJson();
    _data['categoryData'] = categoryData.toJson();
    _data['photos'] = photos.map((e) => e.toJson()).toList();

    _data['workingHours'] = workingHours.map((e) => e.toJson()).toList();
    _data['amneties'] = amneties.map((e) => e.toJson()).toList();
    _data['loyaltyInfo'] = loyaltyInfo.toJson();
    _data['pingedCoupons'] = pingedCoupons;
    _data['isFavourite'] = isFavourite;
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

class CategoryData {
  CategoryData({
    required this.dining,
    required this.everyday,
    required this.retail,
  });

  late final Dining dining;
  late final Everyday everyday;
  late final Retail retail;

  CategoryData.fromJson(Map<String, dynamic> json) {
    // dining = Dining.fromJson(json['dining']);
    // everyday = Everyday.fromJson(json['everyday']);
    retail = Retail.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['dining'] = dining.toJson();
    // _data['everyday'] = everyday.toJson();
    _data['retail'] = retail.toJson();
    return _data;
  }
}

class Dining {
  Dining({
    this.restaurantService,
    this.menuAssetId,
  });

  late final dynamic restaurantService;
  late final dynamic menuAssetId;

  Dining.fromJson(Map<String, dynamic> json) {
    restaurantService = json['restaurantService'];
    menuAssetId = json['restaurantService'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['restaurantService'] = restaurantService;
    _data['menuAssetId'] = menuAssetId;
    return _data;
  }
}

class Everyday {
  Everyday();

  Everyday.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class Retail {
  Retail({
    required this.couponMenuGroupings,
  });

  late final List<CouponMenuGroupings> couponMenuGroupings;

  Retail.fromJson(Map<String, dynamic> json) {
    couponMenuGroupings = List.from(json['couponMenuGroupings'])
        .map((e) => CouponMenuGroupings.fromJson(e))
        .toList();

    couponMenuGroupings.add(CouponMenuGroupings(
        menuGroup: 'All',
        assetId: '',
        couponIds: [],
        availableInMenu: false,
        isSelected: true));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['couponMenuGroupings'] =
        couponMenuGroupings.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CouponMenuGroupings {
  CouponMenuGroupings({
    required this.menuGroup,
    required this.assetId,
    required this.couponIds,
    required this.availableInMenu,
    this.isSelected = false,
  });

  late final String menuGroup;
  late final String assetId;
  late final List<int> couponIds;
  late final bool availableInMenu;
  late bool isSelected;

  CouponMenuGroupings.fromJson(Map<String, dynamic> json) {
    menuGroup = json['menuGroup'];
    assetId = json['assetId'];
    isSelected = false;
    couponIds = List.castFrom<dynamic, int>(json['couponIds']);
    availableInMenu = json['availableInMenu'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['menuGroup'] = menuGroup;
    _data['assetId'] = assetId;
    _data['couponIds'] = couponIds;
    _data['availableInMenu'] = availableInMenu;
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

  late final dynamic loyaltyType;
  late final int visitFreqInDays;
  late final int percDiscount;

  LoyaltyInfo.fromJson(Map<String, dynamic> json) {
    loyaltyType = null;
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

class StoreCoupons {
  StoreCoupons(
      {required this.couponId,
      required this.couponName,
      required this.couponDesc,
      required this.estimatedValue,
      required this.couponType,
      required this.groupName,
      required this.canRedeem,
      required this.canPing,
      required this.assetID,
      required this.remainingCount,
      this.isSelected = true});

  late final int couponId;
  late final String couponName;
  late final String couponDesc;
  late final String estimatedValue;
  late final String couponType;
  late final String groupName;
  late final bool canRedeem;
  late final bool canPing;
  late bool isSelected;
  late final String assetID;
  late final int remainingCount;

  StoreCoupons.fromJson(Map<String, dynamic> json) {
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
    isSelected = true;
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
