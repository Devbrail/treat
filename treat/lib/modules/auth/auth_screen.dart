import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/modules/auth/widgets/mobile_entry_widget.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';
import 'package:get/get.dart';
import 'package:treat/shared/widgets/action_button.dart';

class AuthScreen extends GetView<AuthController> {
  // final AuthController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
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
                  color: ColorConstants.lightViolet,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CommonWidget.actionbutton(
                            text: 'SKIP',
                            buttoncolor: ColorConstants.skipButtonBoxColor,
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
                            child: Text(
                              'OR'.tr,
                              style: TextStyle(
                                  color: ColorConstants.black,
                                  fontSize: 16,
                                  fontFamily: 'Rubik'),
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
                            onTap: null,
                            child: SvgPicture.asset(
                              'assets/svgs/icon_facebook.svg',
                              width: 38,
                              height: 38,
                            ),
                          ),
                          InkWell(
                            onTap: null,
                            child: SvgPicture.asset(
                              'assets/svgs/icon_apple.svg',
                              width: 38,
                              height: 38,
                            ),
                          ),
                          InkWell(
                            onTap: null,
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
                                  arguments: controller);
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
                    Text(
                      'by_continuing_you_agree_to_our'.tr,
                      style: TextStyle(
                          color: ColorConstants.textColorBlack,
                          fontFamily: 'Rubik',
                          fontSize: 14),
                    ),
                    InkWell(
                      onTap: () =>
                          Get.toNamed(Routes.AUTH + Routes.TermsAndCondition),
                      child: Text(
                        'terms_and_conditions'.tr,
                        style: TextStyle(
                            color: ColorConstants.textColorBlack,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Rubik',
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
