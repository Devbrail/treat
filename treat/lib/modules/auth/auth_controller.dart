import 'dart:async';
import 'dart:async';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/models.dart';
import 'package:treat/models/response/intial_token_response.dart';
import 'package:treat/modules/account/account_controller.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;

  AuthController({required this.apiRepository});

  final SharedPreferences sharedPreferences = Get.find<SharedPreferences>();

  late String? intialToken =
      sharedPreferences.getString(StorageConstants.intialToken);

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future<void> fetchingIntialToken({bool forceUpdate = true}) async {
    printInfo(info: 'Intial token $intialToken');

    if (intialToken == null || intialToken!.isEmpty || forceUpdate) {
      final IntialTokenResponse? result = await apiRepository.initialtoken();
      if (result != null) {
        intialToken = result.respData!.initialToken;
        sharedPreferences.setString(StorageConstants.intialToken, intialToken!);
      }
      // await fetchAuthToken();
    }
  }

  Future<void> fetchAuthToken() async {
    final LoginResponse? result = await apiRepository.authToken(intialToken!);

    if (result != null) {
      loginResponse = result;

      saveTokens(result);
      Utils.saveLoginType(StorageConstants.guest);
    }
  }

//   AUTH SCREEN
  var phoneController = TextEditingController();
  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('91');

  bool hasError = false;

  sentOtpMobile(BuildContext context) async {
    AppFocus.unfocus(context);
    hasError = false;
    update(['eText']);
    String phone = phoneController.text;

    if (!phone.isNumericOnly || phone.length < 8) {
      CommonWidget.toast('Please enter a valid number.');
      return;
    }
    printInfo(info: 'senting otp');

    try {
      final Either? result = await apiRepository.sendOtpPhone(
              data: {'initialToken': intialToken, 'phoneNumber': phone});
      result?.fold((l) => CommonWidget.toast(l), (r) {
        printInfo(info: 'success');
        if (r['success'])
          Get.toNamed(Routes.AUTH + Routes.PhoneOTP, arguments: this);
        else {
          // CommonWidget.toast('Error senting otp');
        }
      });

    } catch (e) {
      print(e);
    }


  }

// EMAIL SIGNUP SCREEN CONTROLLS

  double buttonProgressPercenage = 0;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  String errorMessage = '';

  void listeningTextChange() {
    buttonProgressPercenage = 0;
    if (firstNameController.text.isNotEmpty) buttonProgressPercenage += .33;
    if (lastNameController.text.isNotEmpty) buttonProgressPercenage += .33;
    if (emailController.text.isNotEmpty && emailController.text.isEmail)
      buttonProgressPercenage += .33;

    update([1]);
  }

  void validateEMail() {
    if (!emailController.text.isEmail) {
      errorMessage = '* please enter valid email';
      update([0]);
    } else {
      errorMessage = '';
      update([0]);
    }
  }

  sentOtpEmail(BuildContext context) async {
    AppFocus.unfocus(context);

    printInfo(info: 'senting otp to email');

    final Either? result = await apiRepository.sendOtpEmail(data: {
      'initialToken': intialToken,
      'emailId': emailController.text,
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
    });

    result?.fold((l) => CommonWidget.toast(l), (r) {
      printInfo(info: 'success');
      Get.toNamed(Routes.AUTH + Routes.EmailOTP, arguments: this);
    });
  }

// ===========================================================================

//======   OTP VERIFY PAGE   ======================

  resendOtp(BuildContext context) async {
    print('ldkmmf');
    print(intialToken);
    apiRepository.resendOtp(intialToken!);
  }

  verifyOtp(BuildContext context, String otp) async {
    AppFocus.unfocus(context);

    if (!otp.isNumericOnly || otp.length != 4) {
      CommonWidget.toast('Please enter a valid otp');
      return;
    }

    printInfo(info: 'senting otp to email  $intialToken');
    final Either<String, Map>? result = await apiRepository.verifyOTP(data: {
      'initialToken': intialToken,
      'fcmToken': await getFcmToken(),
      'otpValue': otp,
    });

    result?.fold((l) => CommonWidget.toast(l), (r) async {
      printInfo(info: 'success');
      hasError = false;
      if (r['success']) {
        CommonWidget.toast('OTP verifed succesfully');
        printInfo(info: intialToken!);
        handleSigningResponse(r as Map<String, dynamic>);
      } else
        hasError = true;
      update(['eText']);
    });
  }

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> getFcmToken() async {
    String? token = ')';
    return token;
  }

  handleSigningResponse(Map<String, dynamic> res) async {
    loginResponse = LoginResponse.fromJson(res);
    saveTokens(loginResponse!);
    Utils.saveLoginType(StorageConstants.user);
    if (loginResponse!.respData!.missingInfo == 'MOBILE') {
      Get.toNamed(Routes.AUTH + Routes.ProfileCompletion, arguments: this);
    } else if (loginResponse!.respData!.missingInfo == 'EMAIL')
      Get.toNamed(Routes.AUTH + Routes.EmailSignup,
          arguments: [this, CommonConstants.fromOtp]);
    else {
      await Get.find<AccountController>().getUserInfo();

      Get.toNamed(Routes.AUTH + Routes.AuthLoading);
    }
  }

  signInWithFacebook() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.instance.logOut();
    // Trigger the sign-in flow
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: [
      'public_profile',
      'email',
    ]);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((UserCredential value) async {
      socialLogin({
        "initialToken": intialToken,
        "loginProvider": "FACEBOOK",
        "providerUserId": value.user!.uid,
        "emailID": value.user!.email,
        "fcmToken": await getFcmToken()
      });
    }).catchError((e, s) {
      print(e);
      print(s);
      Sentry.captureException(e);
    });
  }

  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((UserCredential value) async {
      socialLogin({
        "initialToken": intialToken,
        "loginProvider": "GOOGLE",
        "providerUserId": value.user!.uid,
        "emailID": value.user!.email,
        "fcmToken": await getFcmToken()
      });
    }).catchError((e, s) {
      print(e);
      print(s);
      Sentry.captureException(e);
    });
  }

  socialLogin(Map data) {
    apiRepository.socialLogin(data).then((value) {
      if (value == -1) CommonWidget.toast('Login Failed');
      handleSigningResponse(value);
    });
  }

  void saveTokens(LoginResponse loginResponse) {
    sharedPreferences.setString(
        StorageConstants.token, loginResponse.respData!.accessToken!);
  }

// ===========================================================================

//======   Profile Completion PAGE   ======================
  var mobileNumberController = TextEditingController();

  var loginResponse;

  void completeProfile(BuildContext context, {required String type}) async {
    AppFocus.unfocus(context);
    String phone = mobileNumberController.text;

    var data = {};

    if (type == 'email') {
      String firstName = firstNameController.text;
      String lastName = lastNameController.text;
      String email = emailController.text;
      data['missing'] = 'EMAIL';
      data['emailId'] = email;
      data['firstName'] = firstName;
      data['lastName'] = lastName;
    } else {
      if (!phone.isNumericOnly || phone.length < 8) {
        CommonWidget.toast('Please enter a valid otp');
        return;
      }
      data['missing'] = 'MOBILE';

      data['phoneNumber'] = phone;
    }

    printInfo(info: 'senting otp to email');
    printInfo(info: data.toString());
    final Either<String, Map>? result =
        await apiRepository.completeProfile(data: data);

    result?.fold((l) => CommonWidget.toast(l), (r) {
      printInfo(info: 'success');
      if (r['success']) {
        Get.offAndToNamed(Routes.AUTH + Routes.AuthLoading);
      } else
        CommonWidget.toast(r['message'] ?? 'Failed');
    });
  }

// ===========================================================================

  selectCountry(Country country) {
    selectedCountry = country;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchingIntialToken(forceUpdate: true);
  }

  refreshController() {
    fetchingIntialToken();
    phoneController = TextEditingController();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumberController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    if (registerFormKey.currentState!.validate()) {
      CommonWidget.toast('Please check the terms first.');

      // final res = await apiRepository.register(
      //   RegisterRequest(
      //     email: registerEmailController.text,
      //     password: registerPasswordController.text,
      //   ),
      // );

      // final prefs =sharedPreferences;
      // if (res!.token.isNotEmpty) {
      //   prefs.setString(StorageConstants.token, res.token);
      //   print('Go to Home screen>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      // }
    }
  }

  String getFormatedPhoneNumber() {
    String phone = selectedCountry.phoneCode + phoneController.text;
    String formattedPhoneNumber = "(+" +
        phone.substring(0, 2) +
        ") " +
        phone.substring(2, 6) +
        "-" +
        phone.substring(6, phone.length);
    return formattedPhoneNumber;
  }

  @override
  void onClose() {
    super.onClose();
    hasError = false;
    // phoneController.dispose();
    //
    // firstNameController.dispose();
    // lastNameController.dispose();
    // emailController.dispose();
    //
    // mobileNumberController.dispose();
  }
}
