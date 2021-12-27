import 'package:get/get.dart';

import 'redeem_controller.dart';

class RedeemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedeemController>(
        () => RedeemController(apiRepository: Get.find()));
  }
}
