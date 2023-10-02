import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomGraphic extends CustomPainter{

  bool isMore;

  CustomGraphic({this.isMore = false});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = linearShaderGradient;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;// Change this to fill

    var path = Path();

    if(isMore) {
      path.moveTo(0, size.height / 10);
      path.quadraticBezierTo(
          0, size.height, size.width, size.height - size.height / 10);
    } else {
      path.moveTo(size.width, size.height / 10);
      path.quadraticBezierTo(
          size.width, size.height, 0, size.height - size.height / 10);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}