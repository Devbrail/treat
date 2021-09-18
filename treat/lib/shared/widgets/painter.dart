import 'package:flutter/cupertino.dart';
import 'package:treat/shared/constants/colors.dart';

class ShapesPainter extends CustomPainter {
  final double curveHeight;
  final Color startColor;
  final Color endColor;
  ShapesPainter({
    required this.curveHeight,
    required this.startColor,
    required this.endColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(0, size.height - curveHeight);
    p.relativeQuadraticBezierTo(size.width / 2, 2 * curveHeight, size.width, 0);
    p.lineTo(size.width, 0);

    p.close();
    Rect rect = new Rect.fromCircle(
      center: new Offset(165.0, 55.0),
      radius: 180.0,
    );

    // a fancy rainbow gradient
    final Gradient gradient = new LinearGradient(
      colors: <Color>[
        startColor,
        endColor,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [
        0.0,
        1.0,
      ],
    );

    // create the Shader from the gradient and the bounding square
    final Paint paint = new Paint()..shader = gradient.createShader(rect);

    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
