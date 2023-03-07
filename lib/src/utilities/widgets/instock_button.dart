import 'package:flutter/material.dart';

class InStockButton extends StatefulWidget {
  InStockButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.theme,
      required this.colorOption,
      this.isLoading = false});

  final String text;
  final ThemeData theme;
  final int colorOption;
  final void Function()? onPressed;
  bool isLoading;

  // Used for colorOptions
  static final int primary = 1;
  static final int secondary = 2;
  static final int accent = 3;

  @override
  State<InStockButton> createState() => _InStockButtonState();
}

class _InStockButtonState extends State<InStockButton> {
  Map<String, Color> ColorPicker() {
    switch (widget.colorOption) {
      case 1:
        return {
          "foreground": widget.theme.primaryColorLight,
          "background": widget.theme.primaryColorDark,
        };
      case 2:
        return {
          "foreground": widget.theme.primaryColorDark,
          "background": widget.theme.cardColor,
        };
      case 3:
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

  displayButtonChild(ThemeData theme) {
    Map<String, Color> buttonColors = ColorPicker();
    if (widget.isLoading == false) {
      return Text(
        widget.text,
        style: widget.theme.textTheme.displaySmall
            ?.copyWith(color: buttonColors["foreground"]),
      );
    } else {
      return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: buttonColors["foreground"],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Color> buttonColors = ColorPicker();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColors["background"],
            // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Rounded edges
            ),
            elevation: 0,
            // No shadow
          ),
          child: displayButtonChild(widget.theme)),
    );
  }
}
