import 'package:flutter/material.dart';

class InStockTextInput extends StatefulWidget {
  InStockTextInput(
      {super.key,
      required this.text,
      required this.theme,
      required this.icon,
      required this.validators,
      required this.onSaved,
      this.obscureText = false,
      this.textInputAction = TextInputAction.none,
      this.onSaved,
      this.onChanged,
      this.icon,
      this.boldLabel = false,
      this.initialValue,
      this.enable = true,
      this.maxLines,
      this.isNumber = false});

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

  @override
  State<InStockTextInput> createState() => _InStockTextInputState();
}

class _InStockTextInputState extends State<InStockTextInput> {
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
              ),
            ),
          ],
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
                  minLines: 1,
                  maxLines: widget.maxLines ?? 1,
                  enabled: widget.enable,
                  initialValue: widget.initialValue,
                  enableSuggestions: true,
                  autocorrect: true,
                  obscureText: widget.obscureText,
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
                  keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
                  inputFormatters: widget.isNumber ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly] : null
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
