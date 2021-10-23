import 'dart:math';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/response/store_dasboard.dart';
import 'package:treat/models/response/users_response.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/shared.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;

  HomeController({required this.apiRepository});

  var currentTab = MainTabs.home.obs;
  var loading = true.obs;
  var currentTabIdx = 0.obs;
  var users = Rxn<UsersResponse>();
  var storeDashboard = Rxn<StoreDashboard>();
  var user = Rxn<Datum>();

  late MainTab mainTab;
  late DiscoverTab discoverTab;
  late ResourceTab resourceTab;
  late InboxTab inboxTab;
  late MeTab meTab;

  @override
  void onInit() async {
    super.onInit();

    mainTab = MainTab();
    loadUsers();
    loadStores('dining');
    discoverTab = DiscoverTab();
    resourceTab = ResourceTab();
    inboxTab = InboxTab();
    meTab = MeTab();
  }

  Future<void> loadStores(String storeType) async {
    setLoading(true);
    apiRepository
        .loadStores(lat: '65', lng: '-141', storeType: storeType)
        .then((value) {
      storeDashboard.value = value?.respData;
      setLoading(false);
    });
  }

  Future<void> loadUsers() async {
    // var _users = await apiRepository.getUsers();
    // if (_users!.data!.length > 0) {
    //   users.value = _users;
    //   users.refresh();
    //   _saveUserInfo(_users);
    // }
  }

  void signOut() {
    var prefs = Get.find<SharedPreferences>();
    prefs.clear();

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
    switch (index) {
      case 0:
        loadStores('dining');
        break;
      case 1:
        loadStores('retail');
        break;
      case 2:
        loadStores('dining');
        break;
      default:
        loadStores('dining');
    }

    index.toString().printInfo();
    currentTabIdx.value = index;
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.home:
        return 1;
      case MainTabs.home:
        return 2;
      case MainTabs.me:
        return 3;
      case MainTabs.me:
        return 4;
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
        return MainTabs.inbox;
      case 4:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }

  setLoading(bool value) {
    loading.value = value;
  }

  List<Stores> get sponsoredShops {
    try {
      return storeDashboard.value!.sections
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
      return storeDashboard.value!.sections
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
      return storeDashboard.value!.sections
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
      List<Stores> stores = storeDashboard.value!.sections
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
      List<Stores> stores = storeDashboard.value!.sections
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
      List<Stores> stores = storeDashboard.value!.sections
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
