import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..shader = const RadialGradient(
        colors: [
          colorMainGradLeft,
          colorMainGradRight,
        ],
      ).createShader(Rect.fromCircle(
        center: const Offset(0, 150),
        radius: 250,
      ));
    //a circle
    canvas.drawCircle(const Offset(90, 150), 90, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}