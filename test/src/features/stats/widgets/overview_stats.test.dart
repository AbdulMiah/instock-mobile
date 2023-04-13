import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/stats/data/stats_dto.dart';
import 'package:instock_mobile/src/features/stats/widgets/overview_stats.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

void main() {
  testWidgets('Displays correct overview stats', (tester) async {
    //Given
    var statsDto1 = StatsDto(overallShopPerformance: {
      "Sale": 795,
      "Order": 0,
      "Return": 0,
      "Giveaway": 112,
      "Damaged": 14,
      "Restocked": 0,
      "Lost": 0,
      "Restock": 506,
      "Just Cuz": 20,
      "Wholesale": 220,
      "Returned": 11
    }, categoryStats: {
      "Stickers": {
        "Sale": 20,
        "Order": 0,
        "Return": 0,
        "Giveaway": 110,
        "Damaged": 0,
        "Restocked": 0,
        "Lost": 0,
        "Restock": 134
      },
      "Water": {
        "Sale": 60,
        "Order": 0,
        "Return": 0,
        "Giveaway": 0,
        "Damaged": 0,
        "Restocked": 0,
        "Lost": 0,
        "Just Cuz": 20
      },
      "poultry": {
        "Sale": 0,
        "Order": 0,
        "Return": 0,
        "Giveaway": 0,
        "Damaged": 0,
        "Restocked": 0,
        "Lost": 0
      },
      "Cards": {
        "Sale": 43,
        "Order": 0,
        "Return": 0,
        "Giveaway": 0,
        "Damaged": 0,
        "Restocked": 0,
        "Lost": 0,
        "Wholesale": 220,
        "Restock": 48
      },
      "Bookmarks": {
        "Sale": 605,
        "Order": 0,
        "Return": 0,
        "Giveaway": 2,
        "Damaged": 14,
        "Restocked": 0,
        "Lost": 0,
        "Restock": 179,
        "Returned": 10
      },
      "blorp": {
        "Sale": 30,
        "Order": 0,
        "Return": 0,
        "Giveaway": 0,
        "Damaged": 0,
        "Restocked": 0,
        "Lost": 0,
        "Restock": 10
      }
    }, salesByMonth: {
      "2023": {"Apr": 277, "Mar": 518}
    }, deductionsByMonth: {
      "2023": {"Mar": 322, "Apr": 94, "Jan": 20}
    }, suggestions: {
      "bestSellingItem": {
        "605": {
          "sku": "BKM-CHK",
          "businessId": "c4866530-ca3b-4145-a494-7c21f610cd40",
          "category": "Bookmarks",
          "name": "Bin Chicken",
          "stock": "0",
          "stockUpdates": [
            {
              "amountChanged": 10,
              "reasonForChange": "Sale",
              "dateTimeAdded": "2023-03-22T13:50:00.1365932+00:00"
            },
            {
              "amountChanged": 10,
              "reasonForChange": "Sale",
              "dateTimeAdded": "2023-03-22T13:50:03.1927909+00:00"
            },
            {
              "amountChanged": -4,
              "reasonForChange": "Damaged",
              "dateTimeAdded": "2023-04-13T18:09:43.9043593+01:00"
            }
          ],
          "errorNotification": {"errors": {}, "hasErrors": false}
        }
      },
      "worstSellingItem": {
        "0": {
          "sku": "UP1O4D6",
          "businessId": "c4866530-ca3b-4145-a494-7c21f610cd40",
          "category": "Upload",
          "name": "Image url6",
          "stock": "1",
          "stockUpdates": [],
          "errorNotification": {"errors": {}, "hasErrors": false}
        }
      },
      "itemToRestock": {
        "1:0": {
          "sku": "BKM-CHK",
          "businessId": "c4866530-ca3b-4145-a494-7c21f610cd40",
          "category": "Bookmarks",
          "name": "Bin Chicken",
          "stock": "0",
          "stockUpdates": [
            {
              "amountChanged": 10,
              "reasonForChange": "Sale",
              "dateTimeAdded": "2023-03-22T13:50:00.1365932+00:00"
            },
            {
              "amountChanged": 10,
              "reasonForChange": "Sale",
              "dateTimeAdded": "2023-03-22T13:50:03.1927909+00:00"
            },
            {
              "amountChanged": -4,
              "reasonForChange": "Damaged",
              "dateTimeAdded": "2023-04-13T18:09:43.9043593+01:00"
            }
          ],
          "errorNotification": {"errors": {}, "hasErrors": false}
        }
      },
      "longestNoSales": {
        "22 days": {
          "sku": "265-934-1E3-854",
          "businessId": "c4866530-ca3b-4145-a494-7c21f610cd40",
          "category": "Water",
          "name": "Evian",
          "stock": "32",
          "stockUpdates": [
            {
              "amountChanged": -20,
              "reasonForChange": "Just Cuz",
              "dateTimeAdded": "2023-01-01T00:00:00"
            },
            {
              "amountChanged": 30,
              "reasonForChange": "Sale",
              "dateTimeAdded": "2023-03-22T14:00:48.205964+00:00"
            },
            {
              "amountChanged": 30,
              "reasonForChange": "Sale",
              "dateTimeAdded": "2023-03-22T14:18:53.8288488+00:00"
            }
          ],
          "errorNotification": {"errors": {}, "hasErrors": false}
        }
      },
      "bestSellingCategory": {},
      "worstSellingCategory": {"0": "Cards"},
      "mostReturns": {
        "10": {
          "sku": "BKM-CHK",
          "businessId": "c4866530-ca3b-4145-a494-7c21f610cd40",
          "category": "Bookmarks",
          "name": "Bin Chicken",
          "stock": "0",
          "stockUpdates": [
            {
              "amountChanged": 10,
              "reasonForChange": "Sale",
              "dateTimeAdded": "2023-03-22T13:50:00.1365932+00:00"
            },
            {
              "amountChanged": 10,
              "reasonForChange": "Sale",
              "dateTimeAdded": "2023-03-22T13:50:03.1927909+00:00"
            }
          ],
          "errorNotification": {"errors": {}, "hasErrors": false}
        }
      },
      "errorNotification": {"errors": {}, "hasErrors": false}
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
    final ordersFinder = find.text('Orders: 0');
    final returnsFinder = find.text('Returns: 11');
    final giveawaysFinder = find.text('Giveaways: 112');
    final damagedFinder = find.text('Damaged: 14');
    final restockedFinder = find.text('Restocked: 506');
    final lostFinder = find.text('Lost: 0');

    //Then
    expect(ordersFinder, findsOneWidget);
    expect(returnsFinder, findsOneWidget);
    expect(giveawaysFinder, findsOneWidget);
    expect(damagedFinder, findsOneWidget);
    expect(restockedFinder, findsOneWidget);
    expect(lostFinder, findsOneWidget);
  });
}
