import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../objects/uppercase_text_formatter.dart';

class InStockTextInput extends StatefulWidget {
  InStockTextInput(
      {super.key,
      required this.text,
      required this.theme,
      required this.validators,
      this.obscureText = false,
      this.textInputAction = TextInputAction.none,
      this.onSaved,
      this.onChanged,
      this.icon,
      this.boldLabel = false,
      this.initialValue,
      this.enable = true,
      this.maxLines,
      this.isNumber = false,
      this.isUnique = false,
      this.controller});

  final ThemeData theme;
  final String text;
  bool isNumber = false;
  final List<Function> validators;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  bool obscureText = false;
  bool boldLabel = false;
  IconData? icon;
  TextInputAction textInputAction = TextInputAction.none;
  final String? initialValue;
  bool enable = true;
  final int? maxLines;
  bool isUnique = false;
  final TextEditingController? controller;

  @override
  State<InStockTextInput> createState() => _InStockTextInputState();
}

class _InStockTextInputState extends State<InStockTextInput> {
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

  setInputFormatter() {
    if (widget.isNumber) {
      return [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6)
      ];
    } else if (widget.isUnique) {
      return [
        LengthLimitingTextInputFormatter(15),
        UpperCaseTextFormatter()
      ];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text,
            style: widget.boldLabel
                ? widget.theme.textTheme.labelMedium
                : widget.theme.textTheme.bodySmall),
        Row(
          children: [
            // displayIcon(),
            Expanded(
              child: TextFormField(
                  controller: widget.controller,
                  minLines: 1,
                  maxLines: widget.maxLines ?? 1,
                  style: widget.theme.textTheme.bodySmall,
                  enabled: widget.enable,
                  initialValue: widget.initialValue,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: widget.onChanged,
                  enableSuggestions: true,
                  autocorrect: true,
                  obscureText: widget.obscureText,
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
                  keyboardType: widget.isNumber
                      ? TextInputType.number
                      : TextInputType.text,
                  inputFormatters: setInputFormatter()
              ),
            ),
          ],
        ),
      ],
    );
  }
}
