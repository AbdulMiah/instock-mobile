import 'package:flutter/material.dart';

class InStockRadioButton<T extends Enum> extends StatefulWidget {
  InStockRadioButton({
    required this.text,
    required this.onPressed,
    required this.theme,
    required this.selected,
    required this.groupValue,
    required this.onChanged,
    required this.value,
  });

  final String text;
  final ThemeData theme;
  final void Function()? onPressed;
  bool selected;
  var value;
  var groupValue;
  final void Function(dynamic)? onChanged;

  @override
  State<InStockRadioButton<T>> createState() => _InStockRadioButtonState<T>();
}

class _InStockRadioButtonState<T extends Enum>
    extends State<InStockRadioButton<T>> {
  int colorOption = 1;

  Map<String, Color> ColorPicker() {
    switch (colorOption) {
      case 1:
        return {
          "foreground": widget.theme.primaryColorLight,
          "background": widget.theme.primaryColorDark,
        };
      case 2:
        return {
          "foreground": widget.theme.primaryColorLight,
          "background": widget.theme.splashColor,
        };
      default:
        return {
          "foreground": widget.theme.primaryColorLight,
          "background": widget.theme.splashColor,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Color> buttonColors = ColorPicker();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListTile(
        title: Text(
          widget.text,
          style: widget.theme.textTheme.displaySmall?.copyWith(
            color: buttonColors["foreground"],
          ),
        ),
        selected: widget.selected,
        leading: Radio<T>(
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
