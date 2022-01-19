import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treat/shared/constants/colors.dart';

class NormalText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final double? letterSpacing;
  final String fontFamily;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextOverflow? textOverflow;

  NormalText({
    required this.text,
    this.textColor = ColorConstants.textBlack,
    this.fontSize = 16,
    this.fontFamily = 'Roboto',
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing,
    this.textOverflow = TextOverflow.ellipsis,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: textColor,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      overflow: textOverflow,
      softWrap: true,
    );
  }
}
