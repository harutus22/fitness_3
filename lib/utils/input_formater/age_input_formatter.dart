import 'package:flutter/services.dart';

class AgeInputFormatter extends TextInputFormatter{

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(int.parse(newValue.text) > 120) {
      return TextEditingValue(
          text: "120"
      );
    } else {
      return newValue;
    }
  }

}