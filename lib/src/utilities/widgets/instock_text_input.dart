import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class InStockTextInput extends StatefulWidget {
  InStockTextInput({
    super.key,
    required this.text,
    required this.theme,
    required this.validators,
    this.obscureText = false,
    this.textInputAction = TextInputAction.none,
    this.onSaved,
    this.onChanged,
    this.icon,
  });

  final ThemeData theme;
  final String text;
  final List<Function> validators;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  bool obscureText = false;
  IconData? icon;
  TextInputAction textInputAction = TextInputAction.none;

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

    for (var i = 0; i < widget.validators.length;) {
      Function validator = widget.validators[i];
      String? res = validator(value);
      if (res != null) {
        setErrorMessage(res);

        //We return an empty string to the validator
        //so no error message is displayed from the text format
        //but we set our custom error display to equal the error message
        return "";
      }
      i++;
    }
    setErrorMessage("");

    return null;
  }

  setErrorMessage(String errorMessage) {
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
          _errorMessage = errorMessage;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text, style: widget.theme.textTheme.bodySmall),
        Row(
          children: [
            // displayIcon(),
            Expanded(
              child: TextFormField(
                style: widget.theme.textTheme.bodySmall,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: widget.onChanged,
                enableSuggestions: true,
                autocorrect: true,
                obscureText: widget.obscureText,
                validator: (value) {
                  runValidators(value);
                },
                onSaved: widget.onSaved,
                cursorColor: widget.theme.primaryColorDark,
                textInputAction: widget.textInputAction,
                decoration: InputDecoration(
                  prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
                  prefixIconConstraints:
                      BoxConstraints.loose(Size.fromWidth(1000)),
                  prefixIconColor: widget.theme.primaryColorDark,
                  helperText: (_errorMessage),
                  helperStyle: widget.theme.textTheme.headlineSmall,
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: widget.theme.primaryColorDark)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: widget.theme.primaryColorDark)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: widget.theme.primaryColorDark)),
                  errorBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
