import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:ui' as ui;

class WaterGraphic extends CustomPainter {
  WaterGraphic({required this.drunkInDay, required this.waterLimit});

  List<int> drunkInDay;
  int waterLimit;

  final textStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  @override
  void paint(Canvas canvas, Size size) {


    var bottomLine = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    _drawDashedLine(canvas, size.width, bottomLine, 1, 4, size.height / 2);
    _drawColumns(canvas, size.width, size.height / 2);
  }

  @override
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void _drawColumns(
    Canvas canvas,
    double width,
    double height,
  ) {
    final _textPainter = TextPainter(textDirection:ui.TextDirection.rtl);
    var column = Paint()
      ..color = Color(0xffD9D9D9)
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    var columnFill = Paint()
      ..color = Color(0xff1F55A2)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    final columnSpace = width / 7;
    int weekDay = 0;
    // var wd = DateFormat.EEEE().dateSymbols.NARROWWEEKDAYS;
    var wd = ['M', "T", 'W', 'T', "F", 'S', 'S'];


    do{
      final item = drunkInDay[weekDay] > waterLimit ? waterLimit : drunkInDay[weekDay];
      _textPainter.text = TextSpan(text: wd[weekDay], style: textStyle);
      _textPainter.layout(
        minWidth: 0,
        maxWidth: double.maxFinite,
      );
      final double d = _textPainter.width;

      double progress = (height - 3 - height / 3) * (item / waterLimit);
      canvas.drawLine(Offset(columnSpace * weekDay + columnSpace / 2, height - 3), Offset(columnSpace * weekDay + columnSpace / 2, height / 3), column);
      canvas.drawLine(Offset(columnSpace * weekDay + columnSpace / 2, height - 3), Offset(columnSpace * weekDay + columnSpace / 2, height - 3 - progress), columnFill);
      _textPainter.paint(canvas, Offset(columnSpace * weekDay + columnSpace / 2 - d / 2, height * 1.3));

      ++weekDay;
    } while(weekDay < 7);
  }

  void _drawDashedLine(Canvas canvas, double width, Paint paintDef,
      double dashSize, double gapSize, double height) {
    double strokeVerticalOverflow = height;

    double jointSize;
    double leapSize;
    double? firstDashSize;

    double position = 0.0;
    List<Offset> points = [];

    if (paintDef.strokeCap == StrokeCap.butt) {
      jointSize = dashSize + gapSize;
      leapSize = (width + gapSize) % jointSize;

      if (leapSize != 0) {
        if (gapSize > dashSize && gapSize - leapSize >= dashSize)
          position = leapSize / 2;
        else
          firstDashSize = (dashSize - gapSize + leapSize) / 2;
      }

      if (firstDashSize != null) {
        points.add(Offset(position, strokeVerticalOverflow));
        points.add(Offset(position += firstDashSize, strokeVerticalOverflow));
        position += gapSize;
      }

      do {
        points.add(Offset(position, strokeVerticalOverflow));
        points.add(Offset(position + dashSize, strokeVerticalOverflow));
      } while ((position += jointSize) + dashSize <= width);

      if (firstDashSize != null) {
        points.add(Offset(width - firstDashSize, strokeVerticalOverflow));
        points.add(Offset(width, strokeVerticalOverflow));
      }
    } else {
      dashSize += paintDef.strokeWidth;

      jointSize = dashSize + gapSize;
      leapSize = (width + gapSize) % jointSize;

      position = leapSize / 2;

      // position + pointSize <= width + pointSize
      do {
        points.add(Offset(position, strokeVerticalOverflow));
        points.add(Offset(position + dashSize, strokeVerticalOverflow));
      } while ((position += jointSize) + dashSize <= width);

      if (leapSize < paintDef.strokeWidth) {
        points.first = Offset(
          points.first.dx,
          points.first.dy,
        );
        points.last = Offset(
          points.last.dx,
          points.last.dy,
        );
      }
    }

    canvas.drawPoints(PointMode.lines, points, paintDef);
  }
}
