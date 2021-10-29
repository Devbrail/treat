class ApiConstants {
  static const baseUrl = 'http://treatdev.consumerapi.virtuosoft.in';
  static const storeBaseUrl = 'http://treatdev.storeapi.virtuosoft.in';

  static const List consumerList = [
    ApiConstants.login,
    ApiConstants.phone,
    ApiConstants.email,
    ApiConstants.verify,
    ApiConstants.resendotp,
    ApiConstants.capture
  ];

  static const List headerLess = [
    ApiConstants.phone,
    ApiConstants.email,
    ApiConstants.verify,
    ApiConstants.resendotp,
    ApiConstants.skiplogin,
    ApiConstants.initialtoken
  ];

  static const List storeList = [ApiConstants.storedetails];

  //CONSUMER PREFIX
  static const String initialtoken = '/initialtoken';
  static const String skiplogin = '/skiplogin';
  static const String login = '/api/login';
  static const String phone = '/otp/phone';
  static const String email = '/otp/email';
  static const String verify = '/otp/verify';
  static const String resendotp = '/otp/resendotp';
  static const String capture = '/additionaldetails/capture';
  static const String addFavorite = '/addFavorite';
  static const String removeFavorite = '/removeFavorite';
  static const String favoritestoredetails = '/favoritestoredetails';

//STORE PREFIX
  static const String storedetails = '/storedetails';
  static const String stores = '/home';
}
