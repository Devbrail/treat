import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/modules/auth/widgets/mobile_entry_widget.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/action_button.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class AuthScreen extends GetView<AuthController> {
  final AuthController controller =
      Get.put(AuthController(apiRepository: Get.find()));

  @override
  Widget build(BuildContext context) {
     Utils.setStatusBarColor();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: SizeConfig().screenHeight * .65,
                  width: SizeConfig().screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('$IMAGE_PATH/auth_logo.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CommonWidget.actionbutton(
                            text: 'SKIP',
                            buttoncolor: ColorConstants.skipButtonBoxColor,
                            onTap: () async {
                              await controller.fetchAuthToken();
                              Get.toNamed(Routes.AUTH + Routes.AuthLoading);
                            },
                            textColor: ColorConstants.textColorBlack),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder<AuthController>(builder: (auth) {
                        return MobileEntryWidget(
                            country: auth.selectedCountry,
                            onValuePicked: (Country value) {
                              auth.selectCountry(value);
                            },
                            controller: auth.phoneController,
                            selectedCountry: auth.selectedCountry);
                      }),
                      CommonWidget.rowHeight(height: 4),
                      ActionButton(
                          buttonText: 'SEND OTP',
                          width: double.infinity,
                          onTap: () {
                            controller.sentOtpMobile(context);
                          }),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: ColorConstants.black,
                              height: 1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 14),
                            child: NormalText(
                              text: 'OR'.tr,
                              textColor: ColorConstants.black,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: ColorConstants.black,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      CommonWidget.rowHeight(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.signInWithFacebook();
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/icon_facebook.svg',
                              width: 38,
                              height: 38,
                            ),
                          ),
                          if (Platform.isIOS)
                            InkWell(
                              onTap: null,
                              child: SvgPicture.asset(
                                'assets/svgs/icon_apple.svg',
                                width: 38,
                                height: 38,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          InkWell(
                            onTap: () {
                              controller.signInWithGoogle();
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/icon_search.svg',
                              width: 38,
                              height: 38,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.loginResponse = null;
                              Get.toNamed(Routes.AUTH + Routes.EmailSignup,
                                  arguments: [
                                    controller,
                                    CommonConstants.fromEmail
                                  ]);
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/icon_email.svg',
                              width: 38,
                              height: 38,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CommonWidget.rowHeight(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NormalText(
                      text: 'by_continuing_you_agree_to_our'.tr,
                      textColor: ColorConstants.textColorBlack,
                      fontSize: 14,
                    ),
                    InkWell(
                      onTap: () =>
                          Get.toNamed(Routes.AUTH + Routes.TermsAndCondition),
                      child: Text(
                        'terms_and_conditions'.tr,
                        style: GoogleFonts.roboto(
                            color: ColorConstants.textColorBlack,
                            decoration: TextDecoration.underline,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
