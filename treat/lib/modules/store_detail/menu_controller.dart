import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/response/everyday_store.detail.dart';
import 'package:treat/models/response/store_details.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/shared/shared.dart';

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
       setLoading(false);
    }, (r) {
      storeDetails.value = r;
      setLoading(false);
    });
  }

  EveryDayStore get store => storeDetails.value;

  List<StoreCoupons> get getClipperList {
    List<StoreCoupons> clipCoupons = [];

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
      e.printError();
    }
    return clipCoupons;
  }

  int getQuantity(int couponID) {
    int quantity = 0;
    store.couponsInStoreCart
        .where((element) => element.couponId == couponID)
        .forEach((element) {
      quantity = element.quantity;
    });

    return quantity;
  }

  void updateCart(int couponID, {required bool isAdd}) async {
    dynamic result = await apiRepository.addRemoveCart(
        '?StoreId=${store.storeId}&CouponId=$couponID&Quantity=0&Operation=${isAdd ? 'ADD' : 'REMOVE'}');

    if (result == 0) {
      List<CartData> couponsInStoreCart = storeDetails.value.couponsInStoreCart
          .where((element) => element.couponId == couponID)
          .toList();
      if (couponsInStoreCart.isEmpty) {
        storeDetails.value.couponsInStoreCart
            .add(CartData(couponId: couponID, quantity: 1));
      } else {
        (storeDetails.value as EveryDayStore)
            .couponsInStoreCart
            .forEach((element) {
          if (element.couponId == couponID) {
            element.quantity = isAdd ? ++element.quantity : --element.quantity;
          }
        });
      }
      storeDetails.refresh();
    } else if (result is String) {
      CommonWidget.toast(result);
    } else
      CommonWidget.toast('Failed to update cart');
  }

  void favouriteButtonAction(bool isFavourite, int storeID) async {
    Either<String, Map<dynamic, dynamic>>? response;
    Map<String, dynamic> data = {'storeId': storeID};
    response = await apiRepository.toggleFavourite(data: data);

    response?.fold((l) => CommonWidget.toast('Failed to Update'), (r) {
      if (r['success']) {
        storeDetails.value.isFavourite = !storeDetails.value.isFavourite;

        HomeController controller =
            Get.put(HomeController(apiRepository: Get.find()));
        controller.updateIsFavourite(storeID, isFavourite);
        update(['fav']);
      } else
        CommonWidget.toast('Failed to Update');
    });

    setLoading(false);
  }

  void selectCoupon(int couponID) {
    StoreDetails storeDetail = this.storeDetails.value;
    storeDetail.storeCoupons.forEach((element) {
      element.isSelected = false;
      if (element.couponId == couponID)
        element.isSelected = !element.isSelected;
    });
    update(['ping']);
    storeDetails.refresh();
  }

  void filterList(String name, List<int> couponIds) {
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
