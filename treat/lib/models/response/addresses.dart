class Addresses {
  Addresses({
    required this.defaultAddressId,
    required this.addressReturns,
  });
  late final int defaultAddressId;
  late final List<AddressReturns> addressReturns;

  Addresses.fromJson(Map<String, dynamic> json) {
    defaultAddressId = json['defaultAddressId'];
    addressReturns = List.from(json['addressReturns'])
        .map((e) => AddressReturns.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['defaultAddressId'] = defaultAddressId;
    _data['addressReturns'] = addressReturns.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AddressReturns {
  AddressReturns({
    required this.addressId,
    required this.addressType,
    required this.latitude,
    required this.longitude,
    required this.addressLine1,
    required this.apartment,
    required this.city,
    required this.province,
    required this.zipCode,
  });
  late final int addressId;
  late final String addressType;
  late final dynamic latitude;
  late final dynamic longitude;
  late final String addressLine1;
  late final String apartment;
  late final String city;
  late final String province;
  late final String zipCode;

  AddressReturns.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    addressType = json['addressType'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressLine1 = json['addressLine1'];
    apartment = json['apartment'];
    city = json['city'];
    province = json['province'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['addressId'] = addressId;
    _data['addressType'] = addressType;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['addressLine1'] = addressLine1;
    _data['apartment'] = apartment;
    _data['city'] = city;
    _data['province'] = province;
    _data['zipCode'] = zipCode;
    return _data;
  }
}