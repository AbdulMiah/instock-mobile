import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/inventory/services/reason_for_change_enum.dart';

class InStockRadioButton extends StatefulWidget {
  InStockRadioButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.theme,
    required this.selected,
    required this.groupValue,
  });

  final String text;
  final ThemeData theme;
  final void Function()? onPressed;
  bool selected;
  int groupValue;

  // Used for colorOptions

  @override
  State<InStockRadioButton> createState() => _InStockRadioButtonState();
}

class _InStockRadioButtonState extends State<InStockRadioButton> {
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
          title: Text(widget.text, style: widget.theme.textTheme.displaySmall
        ?.copyWith(color: buttonColors["foreground"])),
          selected: widget.selected,
          leading: Radio<ReasonForChange>(
    value: ReasonForChange.Correction,
    groupValue: widget.groupValue,
    onChanged: ,


    // onPressed: widget.onPressed,
          // style: ElevatedButton.styleFrom(
          //   backgroundColor: buttonColors["background"],
          //   // Background color
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(5), // Rounded edges
          //   ),
          //   elevation: 0,
          //   // No shadow
          // ),
          // child: Text(widget.text)),
    );
  }
}
