import 'package:fitness/utils/routes.dart';
import 'package:flutter/material.dart';

Widget backButton(BuildContext context, {bool isColor = true, IconData? photo, Function()? backToMain}) {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(
      onPressed: () {
        if(backToMain != null){
          backToMain();
        } else if (photo != null) {
          popScreen(context, argument: true);
        } else {
          popScreen(context, argument: false);
        }
      },
      icon: Icon(photo ?? Icons.arrow_back_ios, color: isColor ? Colors.black : Colors.white),
      alignment: Alignment.bottomCenter,
    ),
  );
}