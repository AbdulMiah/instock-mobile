import 'package:flutter/material.dart';

import '../../theme/common_theme.dart';

class InStockBackButton extends StatelessWidget {
  final Widget page;
  final int colorOption;

  const InStockBackButton(
      {super.key, required this.page, required this.colorOption});

  redirectToPage(context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

// Used for colorOptions
  static const int primary = 1;
  static const int secondary = 2;

  Color ColorPicker() {
    final theme = CommonTheme();

    switch (colorOption) {
      case 1:
        return theme.themeData.primaryColorLight;
      case 2:
        return theme.themeData.primaryColorDark;
      default:
        return theme.themeData.primaryColorLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = ColorPicker();
    return GestureDetector(
      onTap: () {
        redirectToPage(context);
      },
      child: Icon(
        Icons.arrow_back,
        color: buttonColor,
      ),
    );
  }
}
