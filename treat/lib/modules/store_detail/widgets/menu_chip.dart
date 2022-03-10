import 'package:flutter/material.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class MenuChip extends StatelessWidget {
  final Color bGColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final TextOverflow? textOverflow;

  const MenuChip({
    Key? key,
    required this.bGColor,
    this.fontSize = 13,
    required this.text,
    this.margin = const EdgeInsets.only(left: 24, top: 24),
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    required this.textColor,
    this.textOverflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: bGColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: NormalText(
        text: text,
        textColor: textColor,
        fontSize: 13,
        textAlign: TextAlign.start,
        textOverflow: textOverflow,
      ),
    );
  }
}
