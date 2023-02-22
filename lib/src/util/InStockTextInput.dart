import 'package:flutter/material.dart';

class InStockTextInput extends StatefulWidget {
  const InStockTextInput(
      {super.key, required this.text, required this.theme, required this.icon});

  final ThemeData theme;
  final IconData? icon;
  final String text;

  @override
  State<InStockTextInput> createState() => _InStockTextInputState();
}

class _InStockTextInputState extends State<InStockTextInput> {
  displayIcon() {
    if (this.widget.icon != null) {
      return Icon(this.widget.icon);
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
                    ),
                    style: widget.theme.textTheme.bodySmall),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
