import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:treat/library/liquid_progress_indicator-0.4.0/lib/src/liquid_linear_progress_indicator.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/auth_input_field.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class EmailSignup extends StatefulWidget {
  @override
  _EmailSignupState createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  final AuthController controller =
      Get.put(AuthController(apiRepository: Get.find()));

  final String prevPage = Get.arguments[1];

  @override
  void initState() {
    super.initState();
    controller.refreshController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              CommonWidget.actionbutton(
                  onTap: () => Get.back(),
                  text: 'BACK',
                  height: 26,
                  buttoncolor: ColorConstants.backButton,
                  textColor: ColorConstants.white),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 34),
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: SvgPicture.asset(
                          'assets/svgs/icon_email.svg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      NormalText(
                        text: controller.loginResponse == null
                            ? 'Email Sign Up'
                            : 'Complete Profile',
                        fontSize: 24,
                        textColor: ColorConstants.textBlack,
                      ),
                      CommonWidget.rowHeight(height: 64),
                      AuthTextField(
                          hint: 'First Name',
                          controller: controller.firstNameController,
                          onChange: (String text) {
                            controller.listeningTextChange();
                          }),
                      CommonWidget.rowHeight(),
                      AuthTextField(
                          hint: 'Last Name',
                          controller: controller.lastNameController,
                          onChange: (String text) =>
                              controller.listeningTextChange()),
                      CommonWidget.rowHeight(),
                      AuthTextField(
                          hint: 'Email',
                          textInputType: TextInputType.emailAddress,
                          controller: controller.emailController,
                          onChange: (String text) {
                            controller.listeningTextChange();
                          }),
                      CommonWidget.rowHeight(height: 14),
                      GetBuilder<AuthController>(
                          id: 0,
                          builder: (auth) {
                            return Row(
                              children: [
                                NormalText(
                                  text: auth.errorMessage,
                                  fontSize: 14,
                                  textColor: const Color(0xFFE85959),
                                ),
                              ],
                            );
                          }),
                      CommonWidget.rowHeight(),
                      InkWell(
                        onTap: () {
                          controller.validateEMail();
                          prevPage.printInfo();
                          if (prevPage == CommonConstants.fromEmail) {
                            if (controller.buttonProgressPercenage > .9)
                              controller.sentOtpEmail(context);
                          } else
                            controller.completeProfile(context, type: 'email');
                        },
                        child: Container(
                          width: double.infinity,
                          height: CommonConstants.buttonHeight,
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: GetBuilder<AuthController>(
                              id: 1,
                              builder: (auth) {
                                return LiquidLinearProgressIndicator(
                                  value: auth.buttonProgressPercenage,
                                  // Defaults to 0.5.
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xFF363636)),
                                  // Defaults to the current Theme's accentColor.
                                  backgroundColor: ColorConstants.textColorGrey,
                                  // Defaults to the current Theme's backgroundColor.
                                  borderRadius: 8,

                                  direction: Axis.horizontal,
                                  // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                  center: Container(
                                    height: CommonConstants.buttonHeight,
                                    alignment: Alignment.center,
                                    child: NormalText(
                                        text: 'Continue',
                                        textColor: ColorConstants.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                );
                              }),
                        ),
                      ),
                      CommonWidget.rowHeight(height: 8),
                      NormalText(
                        text: '*please fill required fields',
                        fontSize: 14,
                        textColor: const Color(0xFFE85959),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedLiquidLinearProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidLinearProgressIndicatorState();
}

class _AnimatedLiquidLinearProgressIndicatorState
    extends State<_AnimatedLiquidLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController!.addListener(() => setState(() {}));
    _animationController!.repeat();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController!.value * 100;
    return Container(
      width: double.infinity,
      height: CommonConstants.buttonHeight,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: LiquidLinearProgressIndicator(
        value: _animationController!.value,
        backgroundColor: ColorConstants.textColorGrey,
        valueColor: AlwaysStoppedAnimation(const Color(0xFF363636)),
        borderRadius: 12.0,
        center: Container(
          height: CommonConstants.buttonHeight,
          alignment: Alignment.center,
          child: NormalText(
              text: 'Continue',
              textColor: ColorConstants.white,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    );
  }
}
