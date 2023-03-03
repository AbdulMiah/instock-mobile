import 'package:flutter/material.dart';

import '../../theme/common_theme.dart';

class InStockBackButton extends StatelessWidget {
  final Widget page;
  final Color? color;

  const InStockBackButton({super.key, required this.page, this.color});

  redirectToPage(context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    CommonTheme commonTheme = CommonTheme();
    return GestureDetector(
      onTap: () {
        redirectToPage(context);
      },
      child: Icon(
        Icons.arrow_back,
        color: color ?? commonTheme.themeData.primaryColorLight,
      ),
    );
  }
}
