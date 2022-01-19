import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart' as G;
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/response/addresses.dart';
import 'package:treat/models/response/favourite_response.dart';
import 'package:treat/models/response/profile_response.dart';
import 'package:treat/models/response/store_dasboard.dart';
import 'package:treat/models/response/users_response.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;

  HomeController({required this.apiRepository});

  var currentTab = MainTabs.home.obs;
  var loading = true.obs;
  var currentTabIdx = 0.obs;
  var users = Rxn<UsersResponse>();
  var _storeDashboard = Rxn<StoreDashboard>();
  var user = Rxn<Datum>();

  StoreDashboard get storeDashboard => _storeDashboard.value!;

  set storeDashboard(value) {
    _storeDashboard.value = value;
  }

  late MainTab mainTab;
  late FaveTab faveTab;

  @override
  void onInit() async {
    super.onInit();

    mainTab = MainTab();
    loadAddresses();
    if (!Utils.isGuest) getUserInfo();
    faveTab = FaveTab();
  }

  LocationData? locationData;

  Future<void> loadStores({double? lat, double? lng}) async {
    if (getAddress.length < 1 && lat == null) return;

    if (getAddress.length > 0 && getDefAddr!.latitude != 0) {
      '${getDefAddr!.latitude}'.printInfo();

      lat = double.parse(getDefAddr!.latitude.toString());
      lng = double.parse(getDefAddr!.longitude.toString());
    }
    setLoading(true);
    apiRepository
        .loadStores(
            lat: lat.toString(), lng: lng.toString(), storeType: storeType)
        .then((value) {
      if (value != null) {
        locationData =
            LocationData.fromMap({'latitude': lat, 'longitude': lng});
        _storeDashboard.value = value.respData;
        setLoading(false);
      } else
        EasyLoading.showError(
          'Server Unavailable',
        );
    });
  }

  String get storeType {
    switch (currentTabIdx.value) {
      case 0:
        return 'dining';
      case 1:
        return 'retail';
      case 2:
        return 'everyday';

      default:
        return 'dining';
    }
  }

  var favouriteStores = Rxn<List<ConsumerFavoriteStores>>();

  Future<void> getFaves() async {
    setLoading(true);
    // /favoritestoredetails/{latitude}/{longitude}
    apiRepository.favoriteStoreDetails(lat: '65', lng: '-141').then((value) {
      favouriteStores.value = value!.consumerFavoriteStores;
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
    });
  }

  void signOut() async {
    var prefs = Get.find<SharedPreferences>();
    await prefs.clear();

    Get.offAllNamed(Routes.SPLASH);
  }

  void _saveUserInfo(UsersResponse users) {
    // var random = new Random();
    // var index = random.nextInt(users.data!.length);
    // user.value = users.data![index];
    // var prefs = Get.find<SharedPreferences>();
    // prefs.setString(StorageConstants.userInfo, users.data![index].toRawJson());

    // var userInfo = prefs.getString(StorageConstants.userInfo);
    // var userInfoObj = Datum.fromRawJson(xx!);
    // print(userInfoObj);
  }

  void switchTab(index) {
    'sdmsk'.printInfo();
    currentTabIdx.value = index;
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
    switch (index) {
      case 0:
      case 1:
      case 2:
        loadStores();
        break;
      case 3:
        if (!Utils.isGuest) getFaves();
        break;
    }
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.home:
        return 1;
      case MainTabs.home:
        return 2;
      case MainTabs.faveTab:
        return 3;

      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.home;
      case 2:
        return MainTabs.home;
      case 3:
        return MainTabs.faveTab;

      default:
        return MainTabs.home;
    }
  }

  setLoading(bool value) {
    loading.value = value;
  }

  AddressReturns? get getDefAddr {
    try {
      if (defaultAddress.value == CommonConstants.CURRENT_ADDRESS)
        return getAddress.first;
      else
        return addresses.value!.addressReturns
            .where((element) => element.addressId == defaultAddress.value)
            .first;
    } catch (e) {
      return null;
    }
  }

  List<AddressReturns> get getAddress {
    List<AddressReturns> list = [currentAddrReturn];
    try {
      list.addAll(addresses.value!.addressReturns.reversed.toList());
      return list;
    } catch (e, s) {
      return list;
    }
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
        loadStores();
      });
    });
  }

  Future<void> addAddress(Map map) async {
    apiRepository.addConsumerAddresses(map).then((value) {
      value!.fold((l) => null, (r) {
        CommonWidget.toast('Successfully Added');
        loadAddresses();
        Future.delayed(Duration(seconds: 1))
            .then((value) => Get.offNamedUntil(Routes.HOME, (route) => false));
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
          loadStores(lat: value['lat'], lng: value['lng']);
        }
        // fetchCurrentLocation();
      });
    } else
      loadStores();
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
    loadStores(lat: _locationData.latitude, lng: _locationData.longitude);
  }

  setDefaultAddress(LocationData locationData, String address) {
    if (Utils.isGuest ||
        defaultAddress.value == CommonConstants.CURRENT_ADDRESS) {
      currentAddrReturn.latitude = locationData.latitude;
      currentAddrReturn.longitude = locationData.longitude;
      currentAddrReturn.addressLine1 = address;
      defaultAddress.value = currentAddrReturn.addressId;
      defaultAddress.refresh();
    }
  }

  updateIsFavourite(int storeID, bool isFavourite) async {
    if (Utils.isGuest) {
      CommonWidget.toast(
          'You are not authorised to do this action!\nPlease login to continue');

      return;
    }
    Map<String, dynamic> data = {'storeId': storeID};
    Either<String, Map<dynamic, dynamic>>? response;
    response = await apiRepository.toggleFavourite(data: data);

    response?.fold((l) => CommonWidget.toast('Failed to Update'), (r) {
      if (r['success']) {
        if (favouriteStores.value != null &&
            favouriteStores.value!.isNotEmpty) {
          favouriteStores.value!
              .removeWhere((element) => element.storeID == storeID);
          favouriteStores.refresh();
        }
        _storeDashboard.value!.sections.forEach((element) {
          element.stores.forEach((store) {
            if (store.id == storeID) {
              store.isFavourite = !store.isFavourite;
            }
          });
        });
      } else
        CommonWidget.toast('Failed to Update');
    });

    update(['fav']);
  }

  List<Stores> get sponsoredShops {
    try {
      return storeDashboard.sections
          .where((element) => element.title == 'Sponsored Vendor')
          .first
          .stores;
    } catch (e) {
      e.printError();
      return [];
    }
  }

  List<Stores> get topRatedShops {
    try {
      return storeDashboard.sections
          .where((element) => element.title == 'Top Rated')
          .first
          .stores;
    } catch (e) {
      e.printError();
      return [];
    }
  }

  List<Stores> get newToTreat {
    try {
      return storeDashboard.sections
          .where((element) => element.title == 'Top Rated')
          .first
          .stores;
    } catch (e) {
      e.printError();
      return [];
    }
  }

  List<Stores> get allNearbyShops {
    try {
      List<Stores> stores = storeDashboard.sections
          .where((element) => element.title == 'Nearby Offers')
          .first
          .stores;

      return stores;
    } catch (e) {
      e.printError();
      return [];
    }
  }

  List<Stores> get nearbyShops {
    try {
      List<Stores> stores = storeDashboard.sections
          .where((element) => element.title == 'Nearby Offers')
          .first
          .stores;
      if (stores.length > 9)
        return stores.sublist(4, 9);
      else if (stores.length > 3 && stores.length < 9) return stores;
    } catch (e) {
      e.printError();
    }

    return [];
  }

  List<Stores> get balanceNearbyShops {
    try {
      List<Stores> stores = storeDashboard.sections
          .where((element) => element.title == 'Nearby Offers')
          .first
          .stores;
      if (stores.length > 9) return stores.skip(9).toList();
    } catch (e) {
      e.printError();
    }

    return [];
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
    log('djnlks');
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

  AddressReturns currentAddrReturn = AddressReturns(
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
