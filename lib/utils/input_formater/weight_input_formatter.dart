import 'package:flutter/services.dart';

class WeightInputFormatter extends TextInputFormatter{

  bool isKg;

  WeightInputFormatter({
    required this.isKg
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (isKg) {
      if (double.parse(newValue.text) > 635) {
        return const TextEditingValue(
            text: "635"
        );
      } else {
        return newValue;
      }
    } else {
      if (double.parse(newValue.text) > 1400) {
        return const TextEditingValue(
            text: "1400"
        );
      } else {
        return newValue;
      }
    }
  }

}