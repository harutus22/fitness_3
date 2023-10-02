import 'dart:ui';

import 'package:fitness/utils/calculations.dart';
import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';

class MassIndexPainter extends CustomPainter {
  BuildContext context;
  double trianglePos;

  MassIndexPainter({required this.context, required this.trianglePos});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 15.0;
    final paint = [
      Paint()
        ..color = barColorFirst
        ..strokeWidth = strokeWidth,
      Paint()
        ..color = barColorSecond
        ..strokeWidth = strokeWidth,
      Paint()
        ..color = barColorThird
        ..strokeWidth = strokeWidth,
      Paint()
        ..color = barColorFour
        ..strokeWidth = strokeWidth,
      Paint()
        ..color = barColorFive
        ..strokeWidth = strokeWidth,
      Paint()
        ..color = barColorSix
        ..strokeWidth = strokeWidth
    ];

    final wholeWidth = size.width;
    final firstHalf = (wholeWidth / 3 * 2).toInt();
    final secondHalf = wholeWidth ~/ 3;

    var style = const TextStyle(color: Color(0xffB4C1C7));

    final numbers = [15, 16, 18.5, 25, 30, 35, 40];

    final position = [
      0.0,
      firstHalf * 19 ~/ 100,
      firstHalf * 55 ~/ 100,
      firstHalf,
      firstHalf + secondHalf ~/ 3,
      firstHalf + secondHalf ~/ 3 * 2,
      wholeWidth.toInt(),
    ];

    for (var i = 0; i < 6; i++) {
      Offset start = Offset(position[i].toDouble(), size.height);
      Offset end = Offset(position[i + 1].toDouble(), size.height);

      canvas.drawLine(start, end, paint[i]);
    }
    var style1 = ParagraphStyle(
      fontSize: style.fontSize,
      fontFamily: style.fontFamily,
      fontStyle: style.fontStyle,
      fontWeight: style.fontWeight,
      textAlign: TextAlign.justify,
    );

    for (var item = 0; item < position.length; item++) {
      final ParagraphBuilder paragraphBuilder = ParagraphBuilder(style1)
        ..pushStyle(style.getTextStyle());
      paragraphBuilder.addText("${numbers[item]}");
      final Paragraph paragraph = paragraphBuilder.build()
        ..layout(const ParagraphConstraints(width: 30));
      double pos = 0;
      final a = calculateTextSize(context,
          text: numbers[item].toString(), style: style);
      if (item == 0) {
        pos = position[item].toDouble();
      } else if (item == position.length - 1) {
        pos = position[item] - a.width;
      } else {
        pos = position[item] - a.width / 2;
      }

      canvas.drawParagraph(paragraph, Offset(pos, 0));
    }

    const Color strokeColor = Colors.black;
    const PaintingStyle paintingStyle = PaintingStyle.fill;
    Paint trianglePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    final pos = trianglePos - 15;
    final posNumber = (pos / 25 * 100);
    var positionDouble = 0.0;
    if(posNumber <= 40) {
      final secondHalf = pos / 10 * 100;
      const halfFirst = 10;
      const halfSecond = 35;
      if(secondHalf <= halfFirst){
        final firstPercent = (position[1] - position[0]);
        final item = firstPercent * ((pos - (numbers[0] - 15)) / (numbers[1] - numbers[0]));
        positionDouble = position[0] +  item;
        positionDouble = positionDouble < position[0] ? position[0].toDouble() : positionDouble;
      } else if(secondHalf <= halfSecond){
        final firstPercent = (position[2] - position[1]);
        final item = firstPercent * ((pos - (numbers[1] - 15)) / (numbers[2] - numbers[1]));
        positionDouble = position[1] +  item;
      } else {
        final firstPercent = (position[3] - position[2]);
        final item = firstPercent * ((pos - (numbers[2] - 15)) / (numbers[3] - numbers[2]));
        positionDouble = position[2] +  item;
        //TODO fix in range of 18.6 - 21.75, from 22.5 - 25 work normally, and check how works 30, 35, 40
      }
    } else {
      if(posNumber <= 70){
        final firstPercent = (position[4] - position[3]);
        final item = firstPercent * ((pos - (numbers[3] - 15)) / (numbers[4] - numbers[3]));
        positionDouble = position[3] +  item;
      } else if(posNumber <= 85) {
        final firstPercent = (position[5] - position[4]);
        final item = firstPercent * ((pos - (numbers[5] - 15)) / (numbers[5] - numbers[4]));
        positionDouble = position[5] +  item;
      }else {
        final firstPercent = (position[6] - position[5]);
        final item = firstPercent * ((pos - (numbers[6] - 15)) / (numbers[6] - numbers[5]));
        positionDouble = position[6] +  item;
        positionDouble = positionDouble > position[6] ? position[6].toDouble() : positionDouble;
      }
    }
    const triangleX = 14.0;
    const triangleY = 10.0;
    canvas.drawPath(getTrianglePath(triangleX, triangleY, positionDouble - triangleX / 2), trianglePaint);

    Paint linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = 1
      ..style = paintingStyle;
    Offset start = Offset(positionDouble , size.height);
    Offset end = Offset(positionDouble, size.height - strokeWidth / 2);

    canvas.drawLine(start, end, linePaint);

  }

  Path getTrianglePath(double x, double y, double pos) {
    return Path()
      ..moveTo(x / 2 + pos, y + 5)
      ..lineTo(x + pos, 0 + 5)
      ..lineTo(0 + pos, 0 + 5)
      ..lineTo(0 + pos, 0 + 5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
