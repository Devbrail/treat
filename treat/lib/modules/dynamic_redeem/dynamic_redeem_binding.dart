import 'package:get/get.dart';
import 'package:treat/modules/dynamic_redeem/dynamic_redeem_controller.dart';

class DynamicRedeemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicRedeemController>(
            () => DynamicRedeemController(apiRepository: Get.find()));
  }
}
