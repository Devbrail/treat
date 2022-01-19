import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/auth/widgets/mobile_entry_widget.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/utils/common_widget.dart';
import 'package:treat/shared/utils/size_config.dart';
import 'package:treat/shared/widgets/action_button.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import '../auth_controller.dart';

class ProfileCompletion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              CommonWidget.actionbutton(
                  onTap: () => Get.back(),
                  text: 'BACK',
                  height: 26,
                  buttoncolor: ColorConstants.backButton,
                  textColor: ColorConstants.white),
              Container(
                margin: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NormalText(text: 'Complete your profile', fontSize: 24),
                    CommonWidget.rowHeight(),
                    MobileEntryWidget(
                      country: CountryPickerUtils.getCountryByPhoneCode('91'),
                      onValuePicked: (Country value) {
                        controller.selectCountry(value);
                      },
                      controller: controller.mobileNumberController,
                      selectedCountry:
                          CountryPickerUtils.getCountryByPhoneCode('91'),
                    ),
                    CommonWidget.rowHeight(),
                    ActionButton(
                      buttonText: 'Continue',
                      onTap: () {
                        controller.completeProfile(context, type: 'phone');
                      },
                      width: SizeConfig().screenWidth * .4,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
