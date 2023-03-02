import 'package:flutter/material.dart';

import '../../theme/common_theme.dart';

class InStockBackButton extends StatelessWidget {
  final Widget page;

  const InStockBackButton({super.key, required this.page});

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
        color: commonTheme.themeData.primaryColorLight,
      ),
    );
  }
}
