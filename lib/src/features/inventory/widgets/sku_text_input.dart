import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SkuTextInput extends StatefulWidget {
  SkuTextInput(
  {super.key,
  required this.text,
  required this.theme,
  required this.icon,
  required this.validators,
  required this.onSaved,
  this.initialValue,
  this.enable = true,
  this.controller});

  final ThemeData theme;
  final IconData? icon;
  final String text;
  final List<Function> validators;
  final void Function(String?)? onSaved;
  final String? initialValue;
  bool enable = true;
  final TextEditingController? controller;

  @override
  State<SkuTextInput> createState() => _SkuTextInputState();
}

class _SkuTextInputState extends State<SkuTextInput> {
  String? _errorMessage;

  displayIcon() {
    if (widget.icon != null) {
      return Icon(widget.icon);
    }
    return Container();
  }

  String? runValidators(String? value) {
    // Resets error message
    setState(() {
      _errorMessage = null;
    });

    for (var i = 0; i < widget.validators.length;) {
      Function validator = widget.validators[i];
      String? res = validator(value);
      if (res != null) {
        setState(() {
          _errorMessage = res;
        });

        //We return an empty string to the validator
        //so no error message is displayed from the text format
        //but we set our custom error display to equal the error message
        return "";
      }
      i++;
    }
    return null;
  }

  displayErrorMessage() {
    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
        child: SizedBox(
            width: 250,
            child: Text('$_errorMessage',
                style: widget.theme.textTheme.headlineSmall)),
      );
    }
    // For whatever reason putting an empty container here instead
    // causes the text to jump when switching to display text
    // so this is a bit of a work around
    // I don't think it's worth the extra time looking into why already spent an hour
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text, style: widget.theme.textTheme.bodySmall),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom:
              BorderSide(width: 1.0, color: widget.theme.primaryColorDark),
            ),
          ),
          width: 250,
          child: Row(
            children: [
              displayIcon(),
              Expanded(
                child: TextFormField(
                    enabled: widget.enable,
                    controller: widget.controller,
                    initialValue: widget.initialValue,
                    enableSuggestions: true,
                    autocorrect: true,
                    validator: (value) {
                      return runValidators(value);
                    },
                    onSaved: widget.onSaved,
                    cursorColor: widget.theme.primaryColorDark,
                    decoration: InputDecoration(
                      // If widget.icon is not given does not apply margin
                      contentPadding: widget.icon != null
                          ? const EdgeInsets.fromLTRB(4, 0, 0, 0)
                          : null,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      errorStyle: const TextStyle(height: 0),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                      UpperCaseTextFormatter()
                    ],
                ),
              ),
            ],
          ),
        ),
        displayErrorMessage(),
      ],
    );
  }
}

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
