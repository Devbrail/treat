import 'package:get/get.dart';
import 'package:treat/api/api.dart';

import 'modules/account/account_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ApiProvider(), permanent: true);
    Get.put(ApiRepository(apiProvider: Get.find()), permanent: true);
    Get.put(AccountController(apiRepository: Get.find()), permanent: true);
  }
}
