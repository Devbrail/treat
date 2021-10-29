import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/modules/auth/widgets/circular_curve_widget.dart';
import 'package:treat/modules/auth/widgets/pin_input_fields.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class PhoneOtpScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.actionbutton(
                    onTap: () => Get.back(),
                    text: 'BACK',
                    height: 26,
                    buttoncolor: ColorConstants.black,
                    textColor: ColorConstants.white),
                CommonWidget.rowHeight(height: SizeConfig().screenHeight * .1),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NormalText(
                            text: 'Enter verification code sent to',
                            textColor: ColorConstants.textBlack,
                            fontSize: 24),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NormalText(
                            text: controller.getFormatedPhoneNumber(),
                            textColor: ColorConstants.textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ],
                    ),
                    CommonWidget.rowHeight(
                        height: SizeConfig().screenHeight * .1),
                    PinInputField(
                      completed: (otp) => controller.verifyOtp(context, otp),
                    ),
                    CommonWidget.rowHeight(
                        height: SizeConfig().screenHeight * .05),
                    InkWell(
                      onTap: () async {
                        printInfo(info: 'sssssss');
                        Get.back();
                      },
                      child: Container(
                        height: 44,
                        width: SizeConfig().screenWidth * .4,
                        margin: EdgeInsets.only(bottom: 14, top: 10),
                        decoration: BoxDecoration(
                          color: ColorConstants.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: NormalText(
                              text: 'Change Number',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                CircularCurveWidget(
                    startColor: ColorConstants.yellow,
                    endColor: ColorConstants.lightYellow,
                    textColor: ColorConstants.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
