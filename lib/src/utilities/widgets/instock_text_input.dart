import 'package:flutter/material.dart';

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
    this.boldLabel = false,
    this.initialValue,
    this.enable = true
  });

  final ThemeData theme;
  final String text;
  final List<Function> validators;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  bool obscureText = false;
  bool boldLabel = false;
  IconData? icon;
  TextInputAction textInputAction = TextInputAction.none;
  final String? initialValue;
  bool enable = true;

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
        return res;
      } else {
        i++;
      }
    }
    return null;
  }

  displayErrorMessage() {
    if (_errorMessage != null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 4.0, 0, 0),
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
    return Text("");
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
                        ? EdgeInsets.fromLTRB(4, 0, 0, 0)
                        : null,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    errorStyle: TextStyle(height: 0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
