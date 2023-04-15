import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/stats/widgets/stats_box.dart';

import '../../../theme/common_theme.dart';
import '../data/stats_dto.dart';

class CategoryStats extends StatefulWidget {
  final StatsDto statsDto;
  final String dropdownCategory;
  final Function(String) updateCategory;

  const CategoryStats(
      {super.key,
      required this.statsDto,
      required this.dropdownCategory,
      required this.updateCategory});

  @override
  State<CategoryStats> createState() => _CategoryStatsState();
}

class _CategoryStatsState extends State<CategoryStats> {
  String category = "cards";

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: theme.themeData.splashColor,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Sales: ${widget.statsDto.categoryStats[widget.dropdownCategory]["Sale"]}",
                style: theme.themeData.textTheme.displayMedium
                    ?.merge(const TextStyle(fontSize: 24))),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatsBox(
              theme: theme,
              stat: "Orders",
              figure: widget.statsDto.categoryStats[widget.dropdownCategory]
                      ["Order"] ??
                  0,
            ),
            StatsBox(
              theme: theme,
              stat: "Returns",
              figure: widget.statsDto.categoryStats[widget.dropdownCategory]
                      ["Returned"] ??
                  0,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatsBox(
                theme: theme,
                stat: "Giveaways",
                figure: widget.statsDto.categoryStats[widget.dropdownCategory]
                        ["Giveaway"] ??
                    0,
              ),
              StatsBox(
                theme: theme,
                stat: "Damaged",
                figure: widget.statsDto.categoryStats[widget.dropdownCategory]
                        ["Damaged"] ??
                    0,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatsBox(
                theme: theme,
                stat: "Restocked",
                figure: widget.statsDto.categoryStats[widget.dropdownCategory]
                        ["Restock"] ??
                    0,
              ),
              StatsBox(
                theme: theme,
                stat: "Lost",
                figure: widget.statsDto.categoryStats[widget.dropdownCategory]
                        ["Lost"]! ??
                    0,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                width: 150,
              )
            ],
          ),
        ),
      ],
    );
  }
}
