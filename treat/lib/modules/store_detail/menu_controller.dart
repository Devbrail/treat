import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/response/everyday_store.detail.dart';
import 'package:treat/models/response/store_details.dart';

class MenuController extends GetxController {
  final ApiRepository apiRepository;

  MenuController({required this.apiRepository});

  RxBool loading = false.obs;

  var storeDetails = Rxn();

  @override
  void onInit() async {
    super.onInit();
    // if (Get.currentRoute == Routes.EVERYDAY) loadEveryDayStoreDetail('14');
    // else
    //   loadStoreDetail('1');
  }

  Future<void> loadEveryDayStoreDetail(String storeID) async {
    setLoading(true);
    Either<String, EveryDayStore>? response =
        await apiRepository.loadEveryDayStoreDetail(storeID);
    response?.fold((l) {
      printInfo(info: 'sdksmdlks $l');
      setLoading(false);
    }, (r) {
      storeDetails.value = r;
      setLoading(false);
    });
  }

  Future<void> loadStoreDetail(String storeID) async {
    setLoading(true);
    Either<String, StoreDetails>? response =
        await apiRepository.getStoreDetails(storeID);
    response?.fold((l) {
      printInfo(info: 'sdksmdlks $l');
      setLoading(false);
    }, (r) {
      storeDetails.value = r;
      setLoading(false);
    });
  }

  List<StoreCoupons> get getClipperList {
    List<StoreCoupons> clipCoupons = [];
    EveryDayStore store = storeDetails.value;

    try {
      CouponMenuGroupings couponMenuGroupings = store
          .categoryData.retail.couponMenuGroupings
          .where((element) => element.menuGroup == 'Clip Again')
          .first;
      store.storeCoupons.forEach((element) {
        couponMenuGroupings.couponIds.forEach((id) {
          if (element.couponId == id) clipCoupons.add(element);
        });
      });
    } catch (e) {
      e.printInfo();
    }
    return clipCoupons;
  }

  void filterList(String name, List<int> couponIds) {
    EveryDayStore store = storeDetails.value;

    store.categoryData.retail.couponMenuGroupings.forEach((element) {
      // element.isSelected = false;

      if (element.menuGroup == name) {
        if (element.isSelected)
          element.isSelected = false;
        else {
          element.isSelected = true;
        }
      }
      if (name != 'All' && element.menuGroup == 'All')
        element.isSelected = false;
    });

    store.storeCoupons.forEach((storedCoupon) {
      storedCoupon.isSelected = false;

      store.categoryData.retail.couponMenuGroupings
          .where((element) => element.isSelected)
          .forEach((CouponMenuGroupings gp) {
        if (gp.menuGroup == 'All') storedCoupon.isSelected = true;

        gp.couponIds.forEach((id) {
          if (id == storedCoupon.couponId) {
            storedCoupon.isSelected = true;
          }
        });
      });
    });

    if (store.categoryData.retail.couponMenuGroupings
        .where((element) => element.isSelected)
        .isEmpty) {
      store.categoryData.retail.couponMenuGroupings.forEach((e) =>
          e.menuGroup == 'All' ? e.isSelected = true : e.isSelected = false);
      store.storeCoupons.forEach((e) => e.isSelected = true);
    }
    store.categoryData.retail.couponMenuGroupings.sort((a, b) {
      if (a.isSelected) {
        return 1;
      }
      return -1;
    });

    update(['offer']);
  }

  setLoading(bool loading) {
    this.loading.value = loading;
  }
}
