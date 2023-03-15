import 'package:flutter/material.dart';

class InStockRadioButton<T extends Enum> extends StatefulWidget {
  InStockRadioButton({
    required this.text,
    this.onPressed,
    required this.theme,
    required this.groupValue,
    required this.onChanged,
    required this.value,
  });

  final String text;
  final ThemeData theme;
  final void Function()? onPressed;
  dynamic value;
  dynamic groupValue;
  final void Function(dynamic)? onChanged;

  @override
  State<InStockRadioButton<T>> createState() => _InStockRadioButtonState<T>();
}

class _InStockRadioButtonState<T extends Enum>
    extends State<InStockRadioButton<T>> {
  bool _selected = false;

  bool selectionDetector() {
    print(widget.value);
    print(widget.groupValue);
    if (widget.value == widget.groupValue) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: widget.theme.primaryColorDark,
      iconColor: Colors.pink,
      selectedTileColor: widget.theme.splashColor,
      title: Text(
        widget.text,
        style: widget.theme.textTheme.displaySmall?.copyWith(
          color: widget.theme.primaryColorLight,
        ),
        selectionColor: widget.theme.primaryColorLight,
      ),
      selected: _selected,
      leading: Radio<T>(
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}
