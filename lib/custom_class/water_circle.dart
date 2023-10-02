import 'dart:math';

import 'package:flutter/material.dart';

class WaterCircle extends CustomPainter {

  WaterCircle({required this.limit, required this.alreadyDrunk});
    int limit;
    int alreadyDrunk;

  @override
  void paint(Canvas canvas, Size size) {
      var paint1 = Paint()
        ..color = Color(0xffD9D9D9)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8;

      var paint1_drunk = Paint()
        ..color = Color(0xff1F55A2)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8;

      final a = size.height / 2.5;
      canvas.drawCircle(Offset(size.width  / 2 , size.height / 2),
          size.height / 2.5, //radians
          paint1);
      double angle = 2 * pi *(alreadyDrunk / limit);
      if(alreadyDrunk == 0) {
        canvas.drawCircle(Offset(size.width / 2, 17),
            (size.height / a), //radians
            paint1_drunk);
      }
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