import 'package:get/get.dart';
import 'package:treat/modules/account/account_binding.dart';
import 'package:treat/modules/account/my_savings.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/modules/auth/auth_loading/auth_loading.dart';
import 'package:treat/modules/auth/email_signup.dart';
import 'package:treat/modules/auth/otp_verify/email_otp_verify_screen.dart';
import 'package:treat/modules/auth/otp_verify/phone_otp_verify_screen.dart';
import 'package:treat/modules/auth/profile_completion/profile_completion_page.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/modules/location_picker/LocationPicker.dart';
import 'package:treat/modules/me/cards/cards_screen.dart';
import 'package:treat/modules/modules.dart';
import 'package:treat/modules/profile/edit_profile.dart';
import 'package:treat/modules/profile/view_profile.dart';
import 'package:treat/modules/redeem/redeem.dart';
import 'package:treat/modules/store_detail/everyday_store_detail.dart';
import 'package:treat/modules/store_detail/menu.dart';
import 'package:treat/modules/store_search/search.dart';
import 'package:treat/modules/store_search/search_screen.dart';
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
    GetPage(
        name: Routes.RetailMenu,
        page: () => RetailMenu(),
        binding: MenuBinding(),
        children: [
          GetPage(name: Routes.MenuDetail, page: () => MenuDetail()),
        ]),
    GetPage(
      name: Routes.EVERYDAY,
      page: () => EveryDayStoreDetail(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_SCREEN,
      page: () => SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.STATIC_REDEEM,
      page: () => StaticRedemption(),
      binding: RedeemBinding(),
    ),
    GetPage(
      name: Routes.LOCATION_PICKER,
      page: () => LocationPicker(),
    ),
    GetPage(
      name: Routes.ACCOUNT,
      binding: AccountBinding(),
      page: () => Account(),
      children: [
        GetPage(name: Routes.MY_SAVINGS, page: () => MySavings()),
        GetPage(name: Routes.VIEW_PROFILE, page: () => ViewProfile()),
        GetPage(name: Routes.EDIT_PROFILE, page: () => EditProfile()),
      ],
    ),
  ];
}
