import 'package:flutter/material.dart';

class WaterArc extends CustomPainter {

  WaterArc({required this.sizePass, required this.width,
    required this.limit, required this.alreadyDrunk, required this.progress});
    Size? sizePass;
    double width;
    int limit;
    int alreadyDrunk;
    double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if(alreadyDrunk <= limit && sizePass != null) {
      final percentage = progress;
      var paint1 = Paint()
        ..color = Color(0xffD9D9D9)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6;

      var paint1_drunk = Paint()
        ..color = Color(0xff32B5FF)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6;

      var paint2 = Paint()
        ..color = Color(0xffD9D9D9)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      double item = (sizePass!.width - width * 2) / 3;
      double y = -sizePass!.height / 3 * 2;
      canvas.drawArc(Offset(-item , y) & Size(sizePass!.width / 3, sizePass!.width / 3),
          8.5, //radians
          5, //radians
          false,
          paint1);
      canvas.drawArc(Offset(-item , y) & Size(sizePass!.width / 3, sizePass!.width / 3),
          8.5, //radians
          5 * percentage, //radians
          false,
          paint1_drunk
      );

      final path = Path();
      path.moveTo(-item + item / 2, y - y /1.5);
      path.lineTo(-item + item / 1.5, y + sizePass!.width / 3 + y /2);
      path.lineTo(-item - item / 1.5 + sizePass!.width / 3, y + sizePass!.width / 3 + y /2);
      path.lineTo(-item - item / 2 + sizePass!.width / 3, y - y /1.5);
      path.close();
      canvas.drawPath(path, paint2);

      var paint3 = Paint()
        ..color = Color(0xff32B5FF)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill;

      final drunkY = y- y * percentage;
      final drunkX = (-item - item / 1.5 + sizePass!.width / 3) -
          (-item - item / 1.5 + sizePass!.width / 3) * percentage;

      final path2 = Path();
      path2.moveTo(-item + item / 2 + drunkX, y - y /1.5  - drunkY);
      path2.lineTo(-item + item / 1.5, y + sizePass!.width / 3 + y /2);
      path2.lineTo(-item - item / 1.5 + sizePass!.width / 3, y + sizePass!.width / 3 + y /2);
      path2.lineTo(-item - item / 2 + sizePass!.width / 3 - drunkX, y - y /1.5 - drunkY);
      path2.close();
      canvas.drawPath(path2, paint3);
      //TODO draw glass and add drinking animation
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}