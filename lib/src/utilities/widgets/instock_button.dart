import 'package:flutter/material.dart';

class InStockButton extends StatefulWidget {
  InStockButton(
      {super.key,
      this.text,
      required this.onPressed,
      required this.theme,
      required this.colorOption,
      this.icon,
      this.isLoading = false});

  final String? text;
  final ThemeData theme;
  final int colorOption;
  final void Function()? onPressed;
  final IconData? icon;
  bool isLoading;

  // Used for colorOptions
  static const int primary = 1;
  static const int secondary = 2;
  static const int accent = 3;

  @override
  State<InStockButton> createState() => _InStockButtonState();
}

class _InStockButtonState extends State<InStockButton> {
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
      if (widget.text != null && widget.icon == null) {
        return Text(
          widget.text!,
          style: const TextStyle(fontSize: 18),
        );
      } else if(widget.icon != null && widget.text == null) {
        return Icon(widget.icon);
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon),
            const Spacer(),
            Text(
              widget.text!,
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
          ],
        );
      }
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
      ),
    );
  }
}
