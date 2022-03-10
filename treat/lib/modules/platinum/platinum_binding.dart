import 'package:get/get.dart';
import 'package:treat/modules/platinum/platinum_controller.dart';


class PlatinumBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlatinumController>(
            () => PlatinumController(apiRepository: Get.find()));
  }
}
