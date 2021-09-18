import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:treat/shared/constants/colors.dart';

class MyPainter extends CustomPainter {
  final double rippleRadius;
  final double rippleOpacity;
  final double centerCircleRadius;

  MyPainter(
    this.rippleRadius,
    this.rippleOpacity,
    this.centerCircleRadius,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var firstPaint = Paint()
      ..color = ColorConstants.yellow.withOpacity(rippleOpacity)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * .5, size.height * .5),
      rippleRadius,
      firstPaint,
    );

    var secondPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * .5, size.height * .5),
      size.width / 11,
      secondPaint,
    );

    var thirdPaint = Paint()
      ..color = ColorConstants.yellow
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * .5, size.height * .5),
      size.width / centerCircleRadius,
      thirdPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
