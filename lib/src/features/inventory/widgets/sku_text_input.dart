import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SkuTextInput extends StatefulWidget {
  SkuTextInput(
  {super.key,
  required this.text,
  required this.theme,
  required this.validators,
  this.textInputAction = TextInputAction.none,
  this.onSaved,
  this.onChanged,
  this.icon,
  this.initialValue,
  this.controller});

  final ThemeData theme;
  final String text;
  final List<Function> validators;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  IconData? icon;
  TextInputAction textInputAction = TextInputAction.none;
  final String? initialValue;
  bool enable = true;
  final TextEditingController? controller;

  @override
  State<SkuTextInput> createState() => _SkuTextInputState();
}

class _SkuTextInputState extends State<SkuTextInput> {
  displayIcon() {
    if (widget.icon != null) {
      return Icon(widget.icon);
    }
    return Container();
  }

  String? runValidators(String? value) {
    for (var i = 0; i < widget.validators.length;) {
      Function validator = widget.validators[i];
      String? res = validator(value);
      if (res != null) {
        return res;
      } else {
        i++;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text, style: widget.theme.textTheme.bodySmall),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                  controller: widget.controller,
                  style: widget.theme.textTheme.bodySmall,
                  enabled: widget.enable,
                  initialValue: widget.initialValue,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: widget.onChanged,
                  enableSuggestions: true,
                  autocorrect: true,
                  validator: (value) {
                    return runValidators(value);
                  },
                  onSaved: widget.onSaved,
                  cursorColor: widget.theme.primaryColorDark,
                  textInputAction: widget.textInputAction,
                  decoration: InputDecoration(
                    prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
                    prefixIconConstraints:
                    BoxConstraints.loose(Size.fromWidth(1000)),
                    prefixIconColor: widget.theme.primaryColorDark,
                    errorStyle: widget.theme.textTheme.headlineSmall,
                    errorMaxLines: 5,
                    border: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: widget.theme.primaryColorDark)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: widget.theme.primaryColorDark)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: widget.theme.primaryColorDark)),
                    errorBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: widget.theme.highlightColor)),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                    UpperCaseTextFormatter()
                  ],
              ),
            ),
          ],
        ),
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