import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:treat/shared/constants/colors.dart';

class PinInputField extends StatelessWidget {
  Function(String otp)? completed;
  PinInputField({
    Key? key,
    this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 45),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        cursorColor: ColorConstants.lightViolet,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 64,
            fieldWidth: 46,
            selectedColor: ColorConstants.darkGray,
            activeFillColor: ColorConstants.pinInputBackround,
            inactiveColor: Colors.white,
            activeColor: Colors.white,
            inactiveFillColor: ColorConstants.pinInputBackround,
            selectedFillColor: ColorConstants.pinInputBackround,
            fieldOuterPadding: EdgeInsets.all(0)),
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
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
