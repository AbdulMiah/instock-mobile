import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// Taken from https://stackoverflow.com/questions/49238908/flutter-textfield-value-always-uppercase-debounce
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}