import 'package:flutter/material.dart';

import '../../theme/common_theme.dart';

class CategoryHeading extends StatefulWidget {
  const CategoryHeading({super.key, required this.category});

  final String category;

  @override
  State<CategoryHeading> createState() => _CategoryHeadingState();
}

class _CategoryHeadingState extends State<CategoryHeading> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return ListTile(
        title: Text(
      widget.category,
      style: theme.themeData.textTheme.headlineMedium?.merge(TextStyle(
          decoration: TextDecoration.underline,
          decorationThickness: 3,
          shadows: [
            Shadow(
                color: theme.themeData.primaryColorDark,
                offset: const Offset(0, -3))
          ],
          decorationColor: theme.themeData.splashColor,
          color: Colors.transparent)),
    ));
  }
}
