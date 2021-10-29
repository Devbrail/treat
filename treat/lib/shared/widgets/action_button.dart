import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/common.dart';

class ActionButton extends StatelessWidget {
  final height;
  final width;
  final buttonColor;
  final borderRadius;
  final buttonText;
  final buttonTextColor;
  final Function()? onTap;

  const ActionButton({
    required this.buttonText,
    required this.width,
    this.height = 44,
    this.borderRadius,
    this.buttonColor = ColorConstants.black,
    this.buttonTextColor = ColorConstants.white,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: CommonConstants.buttonHeight,
        width: width,
        margin: EdgeInsets.only(bottom: 14, top: 10),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.roboto(
                color: buttonTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}
