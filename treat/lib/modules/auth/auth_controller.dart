import 'dart:async';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/models.dart';
import 'package:treat/models/response/intial_token_response.dart';
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

  Future<void> fetchingIntialToken() async {
    printInfo(info: 'Intial token $intialToken');

    if (intialToken == null || intialToken!.isEmpty) {
      final IntialTokenResponse? result = await apiRepository.initialtoken();
      intialToken = result!.respData!.initialToken;
      sharedPreferences.setString(StorageConstants.intialToken, intialToken!);
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

  sentOtpMobile(BuildContext context) async {
    AppFocus.unfocus(context);

    String phone = phoneController.text;

    if (!phone.isNumericOnly || phone.length < 8) {
      CommonWidget.toast('Please enter a valid number.');
      return;
    }
    printInfo(info: 'senting otp');

    final Either? result = await apiRepository.sendOtpPhone(
        data: {'initialToken': intialToken, 'phoneNumber': phone});

    result?.fold((l) => CommonWidget.toast(l), (r) {
      printInfo(info: 'success');
      if (r['success'])
        Get.toNamed(Routes.AUTH + Routes.PhoneOTP, arguments: this);
      else
        CommonWidget.toast('Error senting otp');
    });
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
    apiRepository.resendOtp(data: {
      'initialToken': intialToken,
    });
  }

  verifyOtp(BuildContext context, String otp) async {
    AppFocus.unfocus(context);

    if (!otp.isNumericOnly || otp.length != 4) {
      CommonWidget.toast('Please enter a valid otp');
      return;
    }

    printInfo(info: 'senting otp to email  $intialToken');
    final Either<String, Map>? result = await apiRepository
        .verifyOTP(data: {'initialToken': intialToken, 'otpValue': otp});

    result?.fold((l) => CommonWidget.toast(l), (r) {
      printInfo(info: 'success');
      if (r['success']) {
        CommonWidget.toast('OTP verifed succesfully');
        printInfo(info: intialToken!);

        loginResponse = LoginResponse.fromJson(r as Map<String, dynamic>);
        saveTokens(loginResponse!);
        Utils.saveLoginType(StorageConstants.user);
        if (loginResponse!.respData!.missingInfo == 'MOBILE') {
          Get.toNamed(Routes.AUTH + Routes.ProfileCompletion, arguments: this);
        } else if (loginResponse!.respData!.missingInfo == 'EMAIL')
          Get.toNamed(Routes.AUTH + Routes.EmailSignup,
              arguments: [this, CommonConstants.fromOtp]);
        else
          Get.toNamed(Routes.AUTH + Routes.AuthLoading);
      } else
        CommonWidget.toast('Invalid OTP');
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

    // phoneController.dispose();
    //
    // firstNameController.dispose();
    // lastNameController.dispose();
    // emailController.dispose();
    //
    // mobileNumberController.dispose();
  }
}
