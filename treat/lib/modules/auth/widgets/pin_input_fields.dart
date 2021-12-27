import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:treat/shared/constants/colors.dart';

class PinInputField extends StatelessWidget {
  Function(String otp)? completed;

  PinInputField({
    Key? key,
    this.selectedColor = ColorConstants.darkGray,
    this.activeFillColor = ColorConstants.pinInputBackround,
    this.inactiveColor = Colors.white,
    this.activeColor = Colors.white,
    this.inactiveFillColor = ColorConstants.pinInputBackround,
    this.selectedFillColor = ColorConstants.pinInputBackround,
    this.hzMargin = 45,
    this.radius = 8,
    this.controller,
    this.onTap,
    this.hideKeyboard = false,
    this.completed,
  }) : super(key: key);
  Color selectedColor;
  Color activeFillColor;
  Color inactiveColor;
  Color activeColor;
  Color inactiveFillColor;
  Color selectedFillColor;
  double hzMargin;
  double radius;
  bool hideKeyboard;
  Function()? onTap;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hzMargin),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        controller: controller,
        animationType: AnimationType.fade,
        cursorColor: ColorConstants.lightViolet,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
        keyboardType: TextInputType.number,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        readOnly: hideKeyboard,
        enabled: !hideKeyboard,
        onTap: onTap,

        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(radius),
            fieldHeight: 63,

            fieldWidth: 46,
            selectedColor: selectedColor,
            activeFillColor: activeFillColor,
            inactiveColor: activeFillColor,
            activeColor: selectedColor,
            inactiveFillColor: inactiveFillColor,
            selectedFillColor: selectedFillColor,
            disabledColor: activeColor,
            fieldOuterPadding: EdgeInsets.all(0)),
        animationDuration: Duration(milliseconds: 300),
        onCompleted: (v) {
          Get.printInfo(info: "Completed");
          completed!(v);
        },
        onChanged: (value) {
          Get.printInfo(info: value);
        },
        beforeTextPaste: (text) {
          Get.printInfo(info: "Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }
}
