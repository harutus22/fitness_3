import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import 'Routes.dart';

Widget next(BuildContext context, String screen, bool isActive, Function() pressed, {String? text, double wide = 300, Object? argument}) {
  return Center(
      child: isActive ? Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
    width: wide,
    height: 60,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.black
    ),
    child: MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      child: Text(
        screen == genderScreen ? imReady.tr() : text ?? nextS.tr(),
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      onPressed: () {
        pressed();
        changeScreen(screen, context, argument: argument);
      },
    ),
  ) : Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        width: wide,
        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey,
        ),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const StadiumBorder(),
          child: Text(
            screen == genderScreen ? imReady.tr() : nextS.tr(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {

          },
        ),
      ));
}
