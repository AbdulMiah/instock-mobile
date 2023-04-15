import 'package:flutter/cupertino.dart';
import 'package:instock_mobile/src/features/stats/data/stats_dto.dart';
import 'package:instock_mobile/src/features/stats/widgets/stats_box.dart';

import '../../../theme/common_theme.dart';

class OverviewStats extends StatelessWidget {
  final StatsDto statsDto;

  const OverviewStats({
    super.key,
    required this.statsDto,
    required this.theme,
  });

  final CommonTheme theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: theme.themeData.splashColor,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Sales: ${statsDto.overallShopPerformance["Sale"]}",
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
              figure: statsDto.overallShopPerformance["Order"] ?? 0,
            ),
            StatsBox(
              theme: theme,
              stat: "Returns",
              figure: statsDto.overallShopPerformance["Returned"] ?? 0,
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
                figure: statsDto.overallShopPerformance["Giveaway"] ?? 0,
              ),
              StatsBox(
                theme: theme,
                stat: "Damaged",
                figure: statsDto.overallShopPerformance["Damaged"] ?? 0,
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
                figure: statsDto.overallShopPerformance["Restock"] ?? 0,
              ),
              StatsBox(
                theme: theme,
                stat: "Lost",
                figure: statsDto.overallShopPerformance["Lost"] ?? 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
