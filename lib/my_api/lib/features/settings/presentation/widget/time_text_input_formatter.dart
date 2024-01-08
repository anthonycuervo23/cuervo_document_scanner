import 'package:flutter/services.dart';
import 'dart:math' as math;

class TimeTextInputFormatter extends TextInputFormatter {
  late RegExp _exp;
  TimeTextInputFormatter({required this.hourMaxValue, required this.minuteMaxValue}) {
    _exp = RegExp(r'^$|[0-9:]+$');
  }

  final int hourMaxValue;
  final int minuteMaxValue;
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_exp.hasMatch(newValue.text)) {
      TextSelection newSelection = newValue.selection;
      final String value = newValue.text;
      String newText;
      String leftChunk = '';
      String rightChunk = '';

      if (value.length > 1 && (int.tryParse(value.substring(0, 2)) ?? 0) == hourMaxValue) {
        if (oldValue.text.contains(':')) {
          leftChunk = value.substring(0, 1);
        } else {
          leftChunk = '${value.substring(0, 2)}:';
          rightChunk = '00';
        }
      } else if (value.length > 5) {
        leftChunk = oldValue.text;
      } else if (value.length == 5) {
        if ((int.tryParse(value.substring(3)) ?? 0) > minuteMaxValue) {
          leftChunk = oldValue.text;
        } else {
          leftChunk = value;
        }
      } else if (value.length == 2) {
        if (oldValue.text.contains(':')) {
          leftChunk = value.substring(0, 1);
        } else {
          if ((int.tryParse(value) ?? 0) > hourMaxValue) {
            leftChunk = oldValue.text;
          } else {
            leftChunk = '${value.substring(0, 2)}:';
            rightChunk = value.substring(2);
          }
        }
      } else {
        leftChunk = value;
      }
      newText = leftChunk + rightChunk;

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(newText.length, newText.length),
        extentOffset: math.min(newText.length, newText.length),
      );

      return TextEditingValue(
        text: newText,
        selection: newSelection,
      );
    }
    return oldValue;
  }
}
