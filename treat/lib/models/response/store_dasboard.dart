class StoreDashboardResponse {
  StoreDashboardResponse({
    required this.success,
    required this.message,
    required this.errorCode,
    required this.respData,
  });

  late final bool success;
  late final String message;
  late final String errorCode;
  late final StoreDashboard respData;

  StoreDashboardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errorCode = json['errorCode'];
    respData = StoreDashboard.fromJson(json['respData']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['errorCode'] = errorCode;
    _data['respData'] = respData.toJson();
    return _data;
  }
}

class StoreDashboard {
  StoreDashboard({
    required this.request,
    required this.banners,
    required this.buttons,
    required this.sections,
  });

  late final Request request;
  late final List<Banners> banners;
  late final List<Buttons> buttons;
  late final List<Sections> sections;

  StoreDashboard.fromJson(Map<String, dynamic> json) {
    request = Request.fromJson(json['request']);
    banners =
        List.from(json['banners']).map((e) => Banners.fromJson(e)).toList();
    buttons =
        List.from(json['buttons']).map((e) => Buttons.fromJson(e)).toList();
    sections =
        List.from(json['sections']).map((e) => Sections.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['request'] = request.toJson();
    _data['banners'] = banners.map((e) => e.toJson()).toList();
    _data['buttons'] = buttons.map((e) => e.toJson()).toList();
    _data['sections'] = sections.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Request {
  Request({
    required this.type,
    required this.consumerLocation,
  });

  late final int type;
  late final ConsumerLocation consumerLocation;

  Request.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    consumerLocation = ConsumerLocation.fromJson(json['consumerLocation']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['consumerLocation'] = consumerLocation.toJson();
    return _data;
  }
}

class ConsumerLocation {
  ConsumerLocation({
    required this.latitude,
    required this.longitude,
  });

  late final String latitude;
  late final String longitude;

  ConsumerLocation.fromJson(Map<String, dynamic> json) {
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

class Banners {
  Banners({
    this.title,
    required this.description,
    required this.assetId,
    required this.onClick,
  });

  late final dynamic title;
  late final String description;
  late final String assetId;
  late final String onClick;

  Banners.fromJson(Map<String, dynamic> json) {
    title = null;
    description = json['description'];
    assetId = json['assetId'];
    onClick = json['onClick'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    _data['assetId'] = assetId;
    _data['onClick'] = onClick;
    return _data;
  }
}

class Buttons {
  Buttons({
    required this.title,
    required this.assetId,
    this.onClick,
  });

  late final String title;
  late final String assetId;
  late final dynamic onClick;

  Buttons.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    assetId = json['assetId'];
    onClick = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['assetId'] = assetId;
    _data['onClick'] = onClick;
    return _data;
  }
}

class Sections {
  Sections({
    required this.title,
    required this.stores,
  });

  late final String title;
  late final List<Stores> stores;

  Sections.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    stores = List.from(json['stores']).map((e) => Stores.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['stores'] = stores.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Stores {
  Stores({
    required this.title,
    required this.id,
    required this.description,
    required this.assetId,
    required this.distance,
    required this.timeInMinutes,
    required this.rating,
    required this.storeSpecialities,
    required this.isFavourite,
  });

  late final String title;
  late final int id;
  late final String description;
  late final String assetId;
  late final String distance;
  late final String timeInMinutes;
  late final String street;
  late final double rating;
  late bool isFavourite;
  late final List<String> storeSpecialities;

  Stores.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    id = json['id'] ?? json['storeID'];
    description = json['description'] ?? "";
    assetId = json['assetId'] ?? "";
    distance = json['distance'] ?? "";
    timeInMinutes = json['timeInMinutes'] ?? "";
    rating = json['rating'] ?? 0;
    isFavourite = json['isFavourite'] ?? false;
    street = json['street'] ?? "";
    if (json['storeSpecialities'] != null)
      storeSpecialities =
          List.castFrom<dynamic, String>(json['storeSpecialities']);
    else
      storeSpecialities = [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['id'] = id;
    _data['description'] = description;
    _data['assetId'] = assetId;
    _data['distance'] = distance;
    _data['timeInMinutes'] = timeInMinutes;
    _data['rating'] = rating;
    _data['storeSpecialities'] = storeSpecialities;
    return _data;
  }
}
