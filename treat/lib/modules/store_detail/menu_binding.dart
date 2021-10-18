import 'package:get/get.dart';

import 'menu_controller.dart';

class MenuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(
        () => MenuController(apiRepository: Get.find()));
  }
}
