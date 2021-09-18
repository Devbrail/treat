import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treat/modules/auth/widgets/timer_widget.dart';
import 'package:treat/shared/utils/size_config.dart';
import 'package:treat/shared/widgets/painter.dart';

class CircularCurveWidget extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Color textColor;
  const CircularCurveWidget({
    Key? key,
    required this.startColor,
    required this.endColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: -pi,
          child: CustomPaint(
            painter: ShapesPainter(
              curveHeight: SizeConfig().screenWidth * .2,
              startColor: startColor,
              endColor: endColor,
            ),
            willChange: true,
            child: Stack(
              children: [
                Container(
                  height: SizeConfig().screenWidth * .9,
                  decoration: BoxDecoration(),
                ),
              ],
            ),
          ),
        ),
        TimerWidget(textColor: textColor)
      ],
    );
  }
}
