import 'package:get/get.dart';

import 'account.dart';
import 'account_controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(
        () => AccountController(apiRepository: Get.find()));
  }
}
