import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatelessWidget {

  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const MyRadioOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.text,
    required this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
        gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [colorMainGradLeft, colorMainGradRight],
        )
      ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
        child: Container(
            decoration: BoxDecoration(
              color: isSelected ? null: Colors.white,
                borderRadius: BorderRadius.circular(60),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white],
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    color: isSelected ? null: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isSelected ? [colorMainGradLeft, colorMainGradRight]: [Colors.white, Colors.white],
                    )
                ),

              ),
            ),
        ),
      ),
          ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black, fontSize: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => onChanged(value),
        // splashColor: Colors.cyan.withOpacity(0.5),
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                _buildLabel(),
                const SizedBox(height: 5),
                _buildText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}