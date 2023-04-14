import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/stats/data/stats_dto.dart';
import 'package:instock_mobile/src/features/stats/widgets/overview_stats.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

void main() {
  testWidgets('Displays correct overview stats', (tester) async {
    //Given
    var statsDto1 = StatsDto(overallShopPerformance: {
      "sales": 98,
      "orders": 102,
      "corrections": 6,
      "returns": 2,
      "giveaways": 10,
      "damaged": 1,
      "restocked": 50,
      "lost": 0
    }, performanceByCategory: {
      "cards": {
        "sales": 40,
        "orders": 42,
        "corrections": 5,
        "returns": 0,
        "giveaways": 5,
        "damaged": 1,
        "restocked": 30,
        "lost": 0
      },
      "stickers": {
        "sales": 22,
        "orders": 24,
        "corrections": 1,
        "returns": 2,
        "giveaways": 3,
        "damaged": 0,
        "restocked": 20,
        "lost": 0
      },
      "bookmarks": {
        "sales": 34,
        "orders": 36,
        "corrections": 0,
        "returns": 0,
        "giveaways": 2,
        "damaged": 0,
        "restocked": 0,
        "lost": 0
      }
    }, salesByMonth: {
      "October": 10,
      "November": 20,
      "December": 15,
      "January": 12,
      "February": 25,
      "March": 20
    }, deductionsByMonth: {
      "October": 2,
      "November": 4,
      "December": 3,
      "January": 1,
      "February": 5,
      "March": 5
    });
    void updateCategory(String value) {
      value;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: OverviewStats(
          statsDto: statsDto1,
          theme: CommonTheme(),
        )),
      ),
    );

    //When
    final ordersFinder = find.text('Orders: 102');
    final correctionsFinder = find.text('Corrections: 3');
    final returnsFinder = find.text('Returns: 2');
    final giveawaysFinder = find.text('Giveaways: 3');
    final damagedFinder = find.text('Damaged: 1');
    final restockedFinder = find.text('Restocked: 50');
    final lostFinder = find.text('Lost: 0');

    //Then
    expect(ordersFinder, findsOneWidget);
    expect(correctionsFinder, findsOneWidget);
    expect(returnsFinder, findsOneWidget);
    expect(giveawaysFinder, findsOneWidget);
    expect(damagedFinder, findsOneWidget);
    expect(restockedFinder, findsOneWidget);
    expect(lostFinder, findsOneWidget);
  });
}
