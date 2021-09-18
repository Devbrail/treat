import 'package:flutter/cupertino.dart';
import 'package:treat/shared/constants/colors.dart';

class NormalText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final String fontFamily;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  NormalText({
    required this.text,
    this.textColor = ColorConstants.black,
    this.fontSize = 16,
    this.fontFamily = 'Rubik',
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.normal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }
}
