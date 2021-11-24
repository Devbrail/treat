import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treat/shared/constants/colors.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final textInputType;
  final int maxLength;
  TextEditingController? controller;
  Function(String text)? onChange;
  final Color fillColor;
  final EdgeInsets padding;

  AuthTextField(
      {Key? key,
      required this.hint,
      this.textInputType = TextInputType.text,
      this.maxLength = 30,
      this.controller,
      this.onChange,
      this.fillColor = ColorConstants.whiteGrey,
      this.padding = const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 45,
      child: TextField(
        autofocus: false,
        controller: controller,
        style: TextStyle(fontSize: 18.0, color: ColorConstants.black),
        textAlign: TextAlign.start,
        keyboardType: textInputType,
        onChanged: onChange,
        maxLength: maxLength,
        decoration: InputDecoration(
          filled: true,
          counterText: "",
          fillColor: fillColor,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintStyle: TextStyle(
            color: ColorConstants.black,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          contentPadding: padding,

          // contentPadding:
          //     const EdgeInsets.only(left: 12, right: 4, bottom: 18),
        ),
      ),
    );
  }
}
