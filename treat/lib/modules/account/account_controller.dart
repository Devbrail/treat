import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/response/addresses.dart';
import 'package:treat/models/response/my_savings.dart';
import 'package:treat/models/response/profile_response.dart';
import 'package:treat/models/response/savings_list.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';

class AccountController extends GetxController {
  final ApiRepository apiRepository;

  AccountController({required this.apiRepository});

  var _months = Rxn<List<Map>>([]);
  var _years = Rxn<List<Map>>([
    {'title': '2021', 'id': 0, 'isSelected': false},
    {'title': '2022', 'id': 1, 'isSelected': true}
  ]);

  List<Map>? get months => _months.value;

  List<Map>? get years => _years.value;

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void onInit() async {
    super.onInit();
    if (!Utils.isGuest) getUserInfo();
    '%%%%%%%%%%%%%%%%%%%'.printInfo();
  }

  var _mySavings = Rxn<MySaving>();

  MySaving get mySavings => _mySavings.value!;
  DateTime _cDate = DateTime.now();

  setLoading(value) {
    _isLoading.value = !value;
    update(['loading']);
  }

  iniMonths() {
    _months.value = Utils.getMonthsInYear();
    isLifeTime = true;
    isGraphView = true;
    getSavingsData('${_cDate.year}/${_cDate.month}');
  }

  getSavingsData(String params) {
    setLoading(isLoading);
    apiRepository.getMySavings(params).then((value) {
      setLoading(isLoading);

      if (value != -1) _mySavings.value = MySaving.fromJson(value);
      _mySavings.value!.entries!.forEach((element) {
        if (mySavings.reqMonth == element.month)
          element.isSelected = true;
        else
          element.isSelected = false;
      });
      _mySavings.refresh();
    });
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

  bool isGraphView = false;
  bool isLifeTime = false;

  updateTenureType(bool isThisYear) {
    if (isLifeTime != isThisYear) {
      isLifeTime = !isLifeTime;
      if (!isThisYear) {
        getSavingsData('${_cDate.year}/${00}');
        getSavingsList('${_cDate.year}/${00}');
      } else {
        getSavingsData('${_cDate.year}/${_cDate.month}');
        getSavingsList('${_cDate.year}/${_cDate.month}');

      }
    }

    // update(['i']);
  }

  updateGraphView() {
    isGraphView = !isGraphView;
    update(['i']);
  }

  Map getChartData(month) {
    print('month ${month.toString()}');
    num h = Get.height / 1.75;
    num tot = 0, value;

    try {
      Entries? entries;
      if (isLifeTime)
        entries =
            mySavings.entries!.firstWhere((element) => element.month == month);
      else {
        Map yesl = years!.firstWhere((element) => element['isSelected']);
        print('yeslyesl');
        if(month.toString().length>1)
        entries = mySavings.entries!
            .firstWhere((element) => element.year == int.parse(month));
        else
        entries = mySavings.entries!
            .firstWhere((element) => element.year == int.parse(yesl['title']));
        print(yesl);
      }
      if (entries != null) {
        tot = entries.amount!;
        value = (tot / h) * 100;

        return {
          'total': tot.toString(),
          'height': h / value.abs(),
          'splits': [
            ...entries.breakUps!.map((e) =>
                {'value': e.amount, 'name': e.name, 'color': getColor(e.name!)})
          ]
        };
      }
    } catch (e, s) {
      print(s);
      // print(e);
    }

    return {'total': '0', 'height': 0, 'splits': []};
  }

  num getEarnings(Map item, String name) {
    try {
      for (int i = 0; i < item['splits'].length; i++) {
        print(item['splits']);
        print(item['splits'][i].runtimeType);
        if (item['splits'][i]['name'] == name)
          return item['splits'][i]['value'];
      }
    } catch (e) {
      print(e);
    }
    return 0;
  }

  getColor(String name) {
    if (name.toLowerCase().contains('din'))
      return ColorConstants.graphDineIn;
    else if (name.toLowerCase().contains('ret'))
      return ColorConstants.graphRetail;
    else if (name.toLowerCase().contains('gro'))
      return ColorConstants.graphGrocery;
    else if (name.toLowerCase().contains('ente'))
      return ColorConstants.graphEntertainment;
  }

  int currentMonth = DateTime.now().month - 1;

  selectTenureYear(int id) {
    _years.value!.forEach((e) {
      if (e['isSelected']) e['isSelected'] = false;

      if (e['id'] == id) e['isSelected'] = true;
    });
    update(['i']);

  }

  selectTenure(int selectedIdx) {
    currentMonth = selectedIdx;
    _months.value!.forEach((e) {
      if (e['isSelected']) e['isSelected'] = false;

      if (e['id'] == selectedIdx) e['isSelected'] = true;
    });

    update(['i']);
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

  SavingList? savingList;

  void getSavingsList(params) {
    apiRepository.getMySavingList(params).then((value) {
      if (value != -1) {
        savingList = SavingList.fromJson(value);
        update(['l']);
      }
    });
  }
}
