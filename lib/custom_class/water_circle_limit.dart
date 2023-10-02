import 'dart:math';

import 'package:flutter/material.dart';

class WaterCircleLimit extends CustomPainter {

  WaterCircleLimit({required this.limit});
    int limit;

  @override
  void paint(Canvas canvas, Size size) {
      var paint1 = Paint()
        ..color = Color(0xffD9D9D9)
        ..strokeCap = StrokeCap.square
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12;

      var paint1_drunk = Paint()
        ..color = Color(0xff1F55A2)
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12;

      canvas.drawCircle(Offset(size.width  / 2 , size.height / 2),
          size.height / 2.5, //radians
          paint1);
      double angle = 2 * pi *(limit / 10);

      canvas.drawArc(Rect.fromCircle(center: Offset(size.width  / 2 , size.height / 2), radius: size.height / 2.5),
          pi * 1.5, //radians
          angle, //radians
          false,
          paint1_drunk
      );
    }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}