part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH = '/';
  static const AUTH = '/auth';
  static const LOGIN = '/login';
  static const PhoneOTP = '/phone_otp';
  static const EmailOTP = '/email_otp';
  static const EmailSignup = '/email_signup';
  static const ProfileCompletion = '/profile_completion';
  static const AuthLoading = '/auth_laoding';
  static const TermsAndCondition = '/terms_and_condition';
  static const REGISTER = '/register';
  static const HOME = '/home';
  static const CARDS = '/cards';
  static const RetailMenu = '/MenusPage';
  static const MenuDetail = '/MenuDetail';
  static const DineINMenu = '/$RetailMenu/Dine';
  static const EVERYDAY = '/Everyday';
  static const SEARCH_SCREEN = '/SearchScreen';
  static const ACCOUNT = '/Account';
  static const VIEW_PROFILE = '/ViewProfile';
  static const EDIT_PROFILE = '/EditProfile';
  static const STATIC_REDEEM = '/StaticRedeem';
  static const LOCATION_PICKER = '/LocationPicker';
  static const MY_SAVINGS = '$ACCOUNT/MySavings';

}
