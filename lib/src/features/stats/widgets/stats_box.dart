import 'package:flutter/cupertino.dart';

import '../../../theme/common_theme.dart';

class StatsBox extends StatelessWidget {
  final String stat;
  final int figure;
  const StatsBox(
      {super.key,
      required this.theme,
      required this.stat,
      required this.figure});

  final CommonTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
          color: theme.themeData.cardColor,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "$stat: $figure",
          style: theme.themeData.textTheme.bodySmall
              ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
