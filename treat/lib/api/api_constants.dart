class ApiConstants {
  static const baseUrl = 'http://treatuat.consumerapi.virtuosoft.in';
  static const storeBaseUrl = 'http://treatuat.storeapi.virtuosoft.in';
  static const miscBaseUrl = 'http://treatuat.miscapi.virtuosoft.in';
  static const API_KEY = 'AIzaSyDsaPA8h1O6afo6J5ZuJFQDORVHo1fsFSU';
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
  static const String getconsumeraddresses = '/getconsumeraddresses';
  static const String makeDefaultAddress = '/makeDefaultAddress';
  static const String capture = '/additionaldetails/capture';
  static const String toggleFavourite = '/toggleFavorite';
  static const String favoritestoredetails = '/favoritestoredetails';
  static const String getProfileDetails = '/getprofiledetails';
  static const String editProfileDetails = '/editprofiledetails';

//STORE PREFIX
  static const String storedetails = '/storedetails';
  static const String stores = '/home';
  static const String searchStores = '/searchstores';
  static const String searchSuggestions = '/searchsuggestions';
  static const String storeAmenities = '/storeAmenities';

//MISC PREFIX
  static const String uploadAsset = '/Asset/uploadasset';
}
