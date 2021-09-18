import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/routes/routes.dart';
import 'package:treat/shared/shared.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(Duration(milliseconds: 2000));
    Get.lazyPut(() => AuthController(apiRepository: Get.find()));
    var storage = Get.find<SharedPreferences>();
    AuthController controller = Get.find();
    if (storage.getString(CommonConstants.INTIAL_TOKEN) == null)
      await controller.fetchingIntialToken();
    try {
      if (storage.getString(StorageConstants.token) != null) {
        Get.offAndToNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.AUTH);
      }
    } catch (e) {
      Get.toNamed(Routes.AUTH);
    }
  }
}
