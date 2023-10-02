import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/core.dart';

class PaywallCustomLine extends CustomPainter {
  double index = 0;
  Color line;
  Color circle;

  PaywallCustomLine(
      {required this.index,
      this.line = Colors.white,
      this.circle = Colors.lightGreenAccent});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = line;
    var circlePaint = Paint()..color = circle;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawLine(Offset(0, 0), Offset(index -10, 0), paint);
    canvas.drawCircle(Offset(index - 10, 0), 3, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
