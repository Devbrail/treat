import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treat/shared/constants/colors.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final textInputType;
  TextEditingController? controller;
  Function(String text)? onChange;
  AuthTextField({
    Key? key,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.controller,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 45,
      child: TextField(
        autofocus: false,
        controller: controller,
        style: TextStyle(fontSize: 22.0, color: ColorConstants.black),
        textAlign: TextAlign.start,
        keyboardType: textInputType,
        onChanged: onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.whiteGrey,
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
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

          // contentPadding:
          //     const EdgeInsets.only(left: 12, right: 4, bottom: 18),
        ),
      ),
    );
  }
}
