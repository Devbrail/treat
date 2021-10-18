import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/response/everyday_store.detail.dart';
import 'package:treat/models/response/store_details.dart';
import 'package:treat/routes/app_pages.dart';

class MenuController extends GetxController {
  final ApiRepository apiRepository;

  MenuController({required this.apiRepository});

  RxBool loading = false.obs;

  var storeDetails = Rxn();

  @override
  void onInit() async {
    super.onInit();
    if (Get.currentRoute == Routes.EVERYDAY)
      loadEveryDayStoreDetail('14');
    else
      loadStoreDetail('1');
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

  void filterList(String name, List<int> couponIds) {
    EveryDayStore store = storeDetails.value;
    for (int i = 0;
        i < store.categoryData.retail.couponMenuGroupings.length;
        i++) {
      try {
        store.categoryData.retail.couponMenuGroupings.forEach((element) {
          element.isSelected = false;
          if (element.menuGroup == name) element.isSelected = true;
        });

        store.storeCoupons.forEach((storedCoupon) {
          storedCoupon.isSelected = false;

          if (name == 'All') {
            storedCoupon.isSelected = true;
          } else if (couponIds.isEmpty) {
            storedCoupon.isSelected = false;
          } else {
            couponIds.forEach((id) {
              if (id == storedCoupon.couponId) storedCoupon.isSelected = true;
            });
          }
        });
      } catch (e) {
        print(e);
        e.printError();
      }
      update(['offer']);
    }
  }

  setLoading(bool loading) {
    this.loading.value = loading;
  }
}
