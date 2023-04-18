import 'package:flutter/material.dart';

import '../../../theme/common_theme.dart';

class NegativeSlide extends StatelessWidget {
  final String suggestionText;

  const NegativeSlide({Key? key, required this.suggestionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.themeData.cardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Text(
              suggestionText,
              textAlign: TextAlign.center,
              style: theme.themeData.textTheme.bodySmall?.merge(
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Icon(
              Icons.insert_chart,
              size: 40,
              color: theme.themeData.primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}
