import 'package:get/get.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/modules/auth/auth_loading/auth_loading.dart';
import 'package:treat/modules/auth/email_signup.dart';
import 'package:treat/modules/auth/otp_verify/email_otp_verify_screen.dart';
import 'package:treat/modules/auth/otp_verify/phone_otp_verify_screen.dart';
import 'package:treat/modules/auth/profile_completion/profile_completion_page.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/modules/me/cards/cards_screen.dart';
import 'package:treat/modules/modules.dart';
import 'package:treat/modules/terms_and_condition/terms_and_condotion.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => AuthScreen(),
      binding: AuthBinding(),
      children: [
        GetPage(name: Routes.PhoneOTP, page: () => PhoneOtpScreen()),
        GetPage(name: Routes.EmailOTP, page: () => EmailOtpScreen()),
        GetPage(name: Routes.EmailSignup, page: () => EmailSignup()),
        GetPage(
            name: Routes.ProfileCompletion, page: () => ProfileCompletion()),
        GetPage(name: Routes.AuthLoading, page: () => AuthLoading()),
        GetPage(
            name: Routes.TermsAndCondition, page: () => TermsAndCondition()),
      ],
    ),
    GetPage(
        name: Routes.HOME,
        page: () => HomeScreen(),
        binding: HomeBinding(),
        children: [
          GetPage(name: Routes.CARDS, page: () => CardsScreen()),
        ]),
  ];
}
