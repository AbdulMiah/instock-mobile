import 'package:flutter/material.dart';

class InStockTextInput extends StatefulWidget {
  const InStockTextInput(
      {super.key,
      required this.text,
      required this.theme,
      required this.icon,
      required this.validators});

  final ThemeData theme;
  final IconData? icon;
  final String text;
  final List<Function> validators;

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

    print("Created");
    print(widget.validators);

    for (var i = 0; i < widget.validators.length;) {
      Function validator = widget.validators[i];
      String? res = validator(value);
      if (res != null) {
        print(res);
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
      return Text('$_errorMessage',
          style: widget.theme.textTheme.headlineSmall);
    }
    return Container();
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
                    validator: (value) {
                      return runValidators(value);
                    },
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
                    style: widget.theme.textTheme.bodySmall),
              ),
            ],
          ),
        ),
        displayErrorMessage(),
      ],
    );
  }
}
