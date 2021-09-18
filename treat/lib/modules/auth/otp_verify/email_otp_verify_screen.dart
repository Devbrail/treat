import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/modules/auth/widgets/circular_curve_widget.dart';
import 'package:treat/modules/auth/widgets/pin_input_fields.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class EmailOtpScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Stack(
            children: [
              CommonWidget.actionbutton(
                  onTap: () => Get.back(),
                  text: 'BACK',
                  height: 26,
                  buttoncolor: ColorConstants.black,
                  textColor: ColorConstants.white,
                  margin: EdgeInsets.all(24)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.rowHeight(
                      height: SizeConfig().screenHeight * .15),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NormalText(
                            text: 'Check your Email',
                            fontSize: 24,
                          ),
                        ],
                      ),
                      CommonWidget.rowHeight(
                          height: SizeConfig().screenHeight * .05),
                      NormalText(
                        text:
                            'An OTP has been sent to your email\nClick the link or Enter OTP below to verify',
                        fontSize: 16,
                        textAlign: TextAlign.center,
                      ),
                      CommonWidget.rowHeight(
                          height: SizeConfig().screenHeight * .1),
                      PinInputField(
                          completed: (String otp) =>
                              controller.verifyOtp(context, otp)),
                      CommonWidget.rowHeight(
                          height: SizeConfig().screenHeight * .05),
                    ],
                  ),
                  Spacer(),
                  CircularCurveWidget(
                    startColor: ColorConstants.violet,
                    endColor: ColorConstants.lightViolet,
                    textColor: ColorConstants.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
