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
    // await storage.clear();
    if (storage.getString(CommonConstants.INTIAL_TOKEN) == null)
      await controller.fetchingIntialToken();
    try {
      Get.printInfo(info: storage.getString(StorageConstants.token)!);
      await Future.delayed(Duration(seconds: 1));

      if (storage.getString(StorageConstants.token) != null) {
        Get.offAndToNamed(Routes.HOME);
        // Get.offAndToNamed(Routes.RetailMenu);
      } else {
        await controller.fetchAuthToken();
        Get.offAndToNamed(Routes.AUTH);
      }
    } catch (e) {
      Get.offAndToNamed(Routes.AUTH);
    }
  }
}
//6633778811
/*{"success":true,"message":"","errorCode":null,"respData":{"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJDb25zdW1lcklkIjoiNjQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ7XCIxXCI6XCIxMC8wOC8yMDIyIDA5OjQ3OjQ0XCJ9IiwibmJmIjoxNjMzNjg2NDY0LCJleHAiOjE2MzM2ODgyNjQsImlzcyI6InZpcnR1b3NvZnQiLCJhdWQiOiJBbnlvbmUifQ.m9cT754TaQ8XY39tfWkMJy91B0S5GiSoNOFgf3JqomM","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJDb25zdW1lcklkIjoiNjQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ7XCIxXCI6XCIxMC8wOC8yMDIyIDA5OjQ3OjQ0XCJ9IiwibmJmIjoxNjMzNjg2NDY0LCJleHAiOjE2MzM2ODgyNjQsImlzcyI6InZpcnR1b3NvZnQiLCJhdWQiOiJBbnlvbmUifQ.m9cT754TaQ8XY39tfWkMJy91B0S5GiSoNOFgf3JqomM","missingInfo":"None"}}*/
