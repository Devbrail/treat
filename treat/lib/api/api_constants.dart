class ApiConstants {
  static const baseUrl = 'http://treatdev.consumerapi.virtuosoft.in';
  static const storeBaseUrl = 'http://treatdev.storeapi.virtuosoft.in';
  static const miscBaseUrl = 'http://treatdev.miscapi.virtuosoft.in';
  static const couponBaseUrl = 'http://treatdev.couponapi.virtuosoft.in';
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
  static const String getconsumeraddresses = '/ProfileAddress/List';
  static const String addConsumerAddresses = '/ProfileAddress/add';
  static const String makeDefaultAddress = '/makeDefaultAddress';
  static const String capture = '/additionaldetails/capture';
  static const String toggleFavourite = '/toggleFavorite';
  static const String favoritestoredetails = '/favoritestoredetails';
  static const String getProfileDetails = '/Profile/getdetails';
  static const String editProfileDetails = '/Profile/updatedetails';
  static const String addRemoveCart = '/Cart/addremoveitem';
  static const String redeemCoupon = '/Redemption/staticcoupon';
  static const String postRating = '/StoreRating/add';
  static const String getMySavings = '/savings';
  static const String getReceivedPings = '/PingCoupon/receivedsummary';
  static const String getSendPings = '/PingCoupon/sentsummary';
  static const String getMySavingList = '/savingslist';

//STORE PREFIX
  static const String storedetails = '/storedetails';
  static const String stores = '/home';
  static const String searchStores = '/searchstores';
  static const String searchSuggestions = '/searchsuggestions';
  static const String storeAmenities = '/storeAmenities';

//MISC PREFIX
  static const String uploadAsset = '/Asset/uploadasset';


//COUPON PREFIX
  static const String couponSummary = '/redeemcoupon/staticcouponsummary';


}
