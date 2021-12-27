import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/response/addresses.dart';
import 'package:treat/models/response/profile_response.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';

class AccountController extends GetxController {
  final ApiRepository apiRepository;

  AccountController({required this.apiRepository});

  var _months = Rxn<List<Map>>([]);

  List<Map>? get months => _months.value;

  void onInit() async {
    super.onInit();
    if (!Utils.isGuest) getUserInfo();
    '%%%%%%%%%%%%%%%%%%%'.printInfo();
  }

  iniMonths() {
    _months.value = Utils.getMonthsInYear();
  }

  LocationData? locationData;

  void signOut() async {
    var prefs = Get.find<SharedPreferences>();
    await prefs.clear();

    Get.offAllNamed(Routes.SPLASH);
  }

  var addresses = Rxn<Addresses>();

  Future<void> loadAddresses() async {
    if (Utils.isGuest) {
      fetchCurrentLocation();
      return;
    }

    apiRepository.getconsumeraddresses().then((value) {
      value!.fold((l) {
        fetchCurrentLocation();
      }, (r) {
        addresses.value = r;
        defaultAddress.value = addresses.value!.defaultAddressId;
        addresses.refresh();
      });
    });
  }

  var defaultAddress = 0.obs;

  selectAddress(AddressReturns address) async {
    if (address.addressId != defaultAddress.value &&
        address.addressId != CommonConstants.CURRENT_ADDRESS) {
      apiRepository.makeDefaultAddress(address.addressId);

      defaultAddress.value = address.addressId;
    }

    if (address.addressId == CommonConstants.CURRENT_ADDRESS) {
      Get.toNamed(Routes.LOCATION_PICKER, arguments: locationData)!
          .then((value) {
        if (value is Map) {
          setDefaultAddress(
              LocationData.fromMap(
                  {'latitude': value['lat'], 'longitude': value['lng']}),
              value['address']);
        }
        // fetchCurrentLocation();
      });
    } else
      defaultAddress.refresh();
  }

  Future<void> fetchCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setDefaultAddress(
        _locationData,
        await Utils.getAddressFromLatLng(
            _locationData.latitude!, _locationData.longitude!));
  }

  setDefaultAddress(LocationData locationData, String address) {
    if (Utils.isGuest ||
        defaultAddress.value == CommonConstants.CURRENT_ADDRESS) {
      currentAddressReturn.latitude = locationData.latitude;
      currentAddressReturn.longitude = locationData.longitude;
      currentAddressReturn.addressLine1 = address;
      defaultAddress.value = currentAddressReturn.addressId;
      defaultAddress.refresh();
    }
  }

  var profileDetails = Rxn<ProfileDetails>();
  TextEditingController firstNameTC = TextEditingController();
  TextEditingController lastNameTC = TextEditingController();

  getUserInfo() async {
    var value = await apiRepository.getProfileDetails();
    if (value != -1) {
      profileDetails.value = value;
      firstNameTC.text = (value).firstName;
      lastNameTC.text = (value).lastName;
      profileDetails.refresh();
    }
  }

  uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 75);

    profileDetails.value!.setAssetUploadedFile(File(image!.path));
    profileDetails.refresh();
    final form = FormData({
      'inputFile': MultipartFile(File(image.path), filename: image.name),
    });
    apiRepository.uploadAsset(form).then((value) {
      if (value != -1)
        profileDetails.value!.setAssetUploadedID(value);
      else
        CommonWidget.toast('Cant upload profile pic');
    });
  }

  saveUserInfo() {
    if (firstNameTC.text.isEmpty) CommonWidget.toast('Please fill First name');

    var dddd = {
      ...profileDetails.value!.toJson(),
      'firstName': firstNameTC.text,
      'lastName': lastNameTC.text
    };
    dddd.printInfo();
    apiRepository.editProfileDetails({
      ...profileDetails.value!.toJson(),
      'firstName': firstNameTC.text,
      'lastName': lastNameTC.text
    }).then((value) async {
      if (value == 0) {
        await getUserInfo();
        Get.back();
      }
    });
  }

  selectMonth(int selectedIdx) {
    _months.value!.forEach((e) {
      if (e['isSelected']) e['isSelected'] = false;

      if (e['id'] == selectedIdx) e['isSelected'] = true;
    });
    '$selectedIdx  ${(selectedIdx - 6).abs()}'.printInfo();

    _months.value = rotate(months!, 0).cast<Map>();
    _months.value = rotate(months!, (selectedIdx - 6).abs()).cast<Map>();
    _months.refresh();
  }

  List<Object> rotate(List<Object> list, int v) {
    if (list.isEmpty) return list;
    var i = v % list.length;
    return list.sublist(i)..addAll(list.sublist(0, i));
  }

  AddressReturns currentAddressReturn = AddressReturns(
      addressId: CommonConstants.CURRENT_ADDRESS,
      addressType: '',
      latitude: 0,
      longitude: 0,
      addressLine1: 'Current Location',
      apartment: '',
      city: '',
      province: '',
      zipCode: '');
}
