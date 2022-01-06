import 'dart:io';

class ProfileDetails {
  ProfileDetails({
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.mobileNumber,
    required this.assetUrl,
  });

  late String firstName;
  late String lastName;
  late final String emailId;
  late final String mobileNumber;
  late final String assetUrl;
  late final String assetId;

  late final num totalSavings;
  late final int couponsUsed;
  late String assetUploaded = '';
  var assetUploadedFile;

  setAssetUploadedID(String id) {
    assetUploaded = id;
  }

  setAssetUploadedFile(File file) {
    assetUploadedFile = file;
  }

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    assetUrl = json['assetUrl'];
    assetId = json['assetId'];
    totalSavings = json['totalSavings'];
    couponsUsed = json['couponsUsed'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['emailId'] = emailId;
    _data['mobileNumber'] = mobileNumber;
    if (assetUploaded.isNotEmpty)
      _data['assetId'] = assetUploaded;
    else
      _data['assetId'] = assetId;

    return _data;
  }
}
