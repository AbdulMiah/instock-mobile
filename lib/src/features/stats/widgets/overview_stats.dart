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
            child: Text("Sales: ${statsDto.overallShopPerformance["sales"]}",
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
              figure: statsDto.overallShopPerformance["orders"]!,
            ),
            StatsBox(
              theme: theme,
              stat: "Corrections",
              figure: 3,
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
                stat: "Returns",
                figure: statsDto.overallShopPerformance["returns"]!,
              ),
              StatsBox(
                theme: theme,
                stat: "Giveaways",
                figure: 3,
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
                stat: "Damaged",
                figure: statsDto.overallShopPerformance["damaged"]!,
              ),
              StatsBox(
                theme: theme,
                stat: "Restocked",
                figure: statsDto.overallShopPerformance["restocked"]!,
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
                stat: "Lost",
                figure: statsDto.overallShopPerformance["lost"]!,
              ),
              const SizedBox(
                width: 150,
              )
            ],
          ),
        ),
      ],
    );
  }
}
