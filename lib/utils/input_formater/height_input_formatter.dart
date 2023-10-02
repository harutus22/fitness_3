import 'package:flutter/services.dart';

class HeightInputFormatter extends TextInputFormatter{
  bool isCm;

  HeightInputFormatter({
    required this.isCm
});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (isCm) {
      if (double.parse(newValue.text) > 251) {
        return const TextEditingValue(
            text: "251"
        );
      } else {
        return newValue;
      }
    } else {
      if (double.parse(newValue.text) > 8.235) {
        return const TextEditingValue(
            text: "8.235"
        );
      } else {
        return newValue;
      }
    }
  }
}