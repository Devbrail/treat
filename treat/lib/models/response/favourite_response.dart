class FavouriteResponse {
  FavouriteResponse({
    required this.consumerMapLocation,
    required this.consumerFavoriteStores,
  });

  late final ConsumerMapLocation consumerMapLocation;
  late final List<ConsumerFavoriteStores> consumerFavoriteStores;

  FavouriteResponse.fromJson(Map<String, dynamic> json) {
    consumerMapLocation =
        ConsumerMapLocation.fromJson(json['consumerMapLocation']);
    consumerFavoriteStores = List.from(json['consumerFavoriteStores'])
        .map((e) => ConsumerFavoriteStores.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['consumerMapLocation'] = consumerMapLocation.toJson();
    _data['consumerFavoriteStores'] =
        consumerFavoriteStores.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ConsumerMapLocation {
  ConsumerMapLocation({
    required this.latitude,
    required this.longitude,
  });

  late final int latitude;
  late final int longitude;

  ConsumerMapLocation.fromJson(Map<String, dynamic> json) {
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

class ConsumerFavoriteStores {
  ConsumerFavoriteStores({
    required this.storeID,
    required this.distance,
    this.time,
    required this.title,
    required this.storeAsset,
    this.description,
    required this.rating,
    required this.type,
    required this.storeMapLocation,
  });

  late final int storeID;
  late final String distance;
  late final dynamic time;
  late final String title;
  late final String couponLayout;
  late final StoreAsset storeAsset;
  late final dynamic description;
  late final dynamic rating;
  late final String type;
  late final StoreMapLocation storeMapLocation;

  ConsumerFavoriteStores.fromJson(Map<String, dynamic> json) {
    storeID = json['storeID'];
    distance = json['distance'];
    time = null;
    title = json['title'];
    couponLayout = json['couponLayout'] ?? "";

    storeAsset = StoreAsset.fromJson(json['storeAsset']);
    description = null;
    rating = double.parse(json['rating'].toString());
    type = json['type'];
    storeMapLocation = StoreMapLocation.fromJson(json['storeMapLocation']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['storeID'] = storeID;
    _data['distance'] = distance;
    _data['time'] = time;
    _data['title'] = title;
    _data['assetId'] = storeAsset.assetId;
    _data['couponLayout'] = couponLayout;
    _data['description'] = description;
    _data['rating'] = rating;
    _data['isFavourite'] = true;
    _data['type'] = type;
    _data['storeMapLocation'] = storeMapLocation.toJson();
    return _data;
  }
}

class StoreAsset {
  StoreAsset({
    required this.assetId,
    required this.priority,
    required this.isActive,
  });

  late final String assetId;
  late final int priority;
  late final bool isActive;

  StoreAsset.fromJson(Map<String, dynamic> json) {
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

class StoreMapLocation {
  StoreMapLocation({
    required this.latitude,
    required this.longitude,
  });

  late final String latitude;
  late final String longitude;

  StoreMapLocation.fromJson(Map<String, dynamic> json) {
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
