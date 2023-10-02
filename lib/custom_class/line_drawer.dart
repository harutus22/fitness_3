import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomLine extends CustomPainter {
  int index = 0;
  bool current = false;
  CustomLine({required this.index, this.current = false});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = mainColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    Offset heightStart;
    Offset heightEnd;
    if(current){
      canvas.drawLine(Offset(0, 100), Offset(0, 0), paint);
    } else {
      if ((index) % 5 == 0) {
        heightStart = Offset(0, 60);
        heightEnd = Offset(0, 10);
      } else {
        heightStart = Offset(0, 55);
        heightEnd = Offset(0, 30);
      }

      canvas.drawLine(heightEnd, heightStart, paint);
      // final textStyle = TextStyle(
      //   color: Colors.black,
      //   fontSize: 20,
      // );
      // final textSpan = TextSpan(
      //   text: index.toString(),
      //   style: textStyle,
      // );
      // final textPainter = TextPainter(
      //   text: textSpan,
      //   textDirection: TextDirection.ltr,
      // );
      // textPainter.layout(
      //   minWidth: 0,
      //   maxWidth: size.width,
      // );
      // final xCenter = (size.width - textPainter.width) / 2;
      // final yCenter = (size.height - textPainter.height) / 2;
      // final offset = Offset(xCenter, yCenter);
      // (index) % 5 == 0 ? textPainter.paint(canvas, offset) : null;
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}