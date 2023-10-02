import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';

class DividerCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = mainColor;
    //a circle
    canvas.drawCircle(const Offset(0, 0), 5, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}