import 'package:flutter/material.dart';

class InStockIconButton extends StatefulWidget {
  InStockIconButton(
  {super.key,
  required this.onPressed,
  required this.theme,
  required this.colorOption,
  required this.icon,
  this.isLoading = false});

  final ThemeData theme;
  final int colorOption;
  final void Function()? onPressed;
  final IconData icon;
  bool isLoading;

  // Used for colorOptions
  static const int primary = 1;
  static const int secondary = 2;
  static const int accent = 3;

  @override
  State<InStockIconButton> createState() => _InStockIconButtonState();
}

class _InStockIconButtonState extends State<InStockIconButton> {
  Map<String, Color> colorPicker() {
    switch (widget.colorOption) {
      case 1:
        return {
          "foreground": widget.theme.primaryColorLight,
          "background": widget.theme.primaryColorDark,
        };
      case 2:
        return {
          "foreground": widget.theme.primaryColorDark,
          "background": widget.theme.primaryColorLight,
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
    if (widget.isLoading == false) {
      return Icon(widget.icon);
    } else {
      Map<String, Color> buttonColors = colorPicker();
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
    Map<String, Color> buttonColors = colorPicker();
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColors["background"],
              // Background color
              foregroundColor: buttonColors["foreground"],
              // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Rounded edges
              ),
              elevation: 0,
              // No shadow
            ),
            child: displayButtonChild(widget.theme)
        )
    );
  }
}
