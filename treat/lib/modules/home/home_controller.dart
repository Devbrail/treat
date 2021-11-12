import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/response/addresses.dart';
import 'package:treat/models/response/favourite_response.dart';
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
    faveTab = FaveTab();
  }

  LocationData? locationData;

  Future<void> loadStores({double? lat, double? lng}) async {
    if (getAddrs.length < 1 && lat == null) return;

    if (getAddrs.length > 0) {
      lat = getDefAddr!.latitude;
      lng = getDefAddr!.longitude;
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
        return 'dining';

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
    var random = new Random();
    var index = random.nextInt(users.data!.length);
    user.value = users.data![index];
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.userInfo, users.data![index].toRawJson());

    // var userInfo = prefs.getString(StorageConstants.userInfo);
    // var userInfoObj = Datum.fromRawJson(xx!);
    // print(userInfoObj);
  }

  void switchTab(index) {
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
      return addresses.value!.addressReturns
          .where((element) => element.addressId == defaultAddress.value)
          .first;
    } catch (e) {
      return null;
    }
  }

  List<AddressReturns> get getAddrs {
    try {
      return addresses.value!.addressReturns;
    } catch (e, s) {
      return [];
    }
  }

  var addresses = Rxn<Addresses>();

  Future<void> loadAddresses() async {
    apiRepository.getconsumeraddresses().then((value) {
      value!.fold((l) {
        if (l == 0) {
          fetchCurrentLocation();
        } else
          CommonWidget.toast('Failed to fetch address');
      }, (r) {
        addresses.value = r;
        defaultAddress.value = addresses.value!.defaultAddressId;
        loadStores();

        addresses.refresh();
      });
    });
  }

  var defaultAddress = 0.obs;

  selectAddress(AddressReturns address) {
    if (address.addressId != defaultAddress.value)
      apiRepository.makeDefaultAddress(address.addressId);

    defaultAddress.value = address.addressId;
    loadStores();
    defaultAddress.refresh();
  }

  void fetchCurrentLocation() async {
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
    loadStores(lat: _locationData.latitude, lng: _locationData.longitude);
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
}
