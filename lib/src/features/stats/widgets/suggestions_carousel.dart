import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/stats/data/stats_dto.dart';

import '../../../theme/common_theme.dart';

class SuggestionsCarousel extends StatelessWidget {
  final StatsDto statsDto;

  const SuggestionsCarousel({required this.statsDto});

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    List<Map<String, String>> suggestionsMaps = extractSuggestions(statsDto);

    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: suggestionsMaps.map((i) {
        return Builder(
          builder: (BuildContext context) {
            String positiveOrNegative = i.keys.first;
            String suggestionText = i.values.first;
            return Container(
                width: MediaQuery.of(context).size.width,
                height: null,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: positiveOrNegative == ('Positive')
                      ? theme.themeData.splashColor
                      : suggestionText == ('Negative')
                          ? theme.themeData.cardColor
                          : theme.themeData.cardColor,
                ),
                child: Text(
                  suggestionText,
                  style: TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
    );
  }

  List<Map<String, String>> extractSuggestions(StatsDto statsDto) {
    List<Map<String, String>> res = [];
    for (var key in statsDto.suggestions.keys) {
      // if there is a suggestion
      if (statsDto.suggestions[key].length > 0) {
        switch (key) {
          case "bestSellingItem":
            String sales = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][sales]["name"];
            String suggestion =
                "With $sales sales, $itemName is your best seller!";
            Map<String, String> sugMap = {
              'Positive': suggestion,
            };
            res.add(sugMap);
            break;
          case "worstSellingItem":
            String sales = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][sales]["name"];
            String suggestion =
                "With $sales sales, $itemName is your worst seller";
            Map<String, String> sugMap = {
              'Negative': suggestion,
            };
            res.add(sugMap);
            break;
          case "itemToRestock":
            String ratio = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][ratio]["name"];
            String suggestion =
                "$itemName is flying off the shelves! We predict this will be "
                "your next item to run out of stock. Better restock soon!";
            Map<String, String> sugMap = {
              'Positive': suggestion,
            };
            res.add(sugMap);
            break;
          case "longestNoSales":
            String days = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][days]["name"];
            String suggestion =
                "$itemName hasn't sold in $days. People don't know what they're missing!";
            Map<String, String> sugMap = {
              'Negative': suggestion,
            };
            res.add(sugMap);
            break;
          case "bestSellingCategory":
            String sales = statsDto.suggestions[key].keys.first;
            String category = statsDto.suggestions[key][sales];
            String suggestion =
                "With $sales sales, $category is your best selling category!";
            Map<String, String> sugMap = {
              'Positive': suggestion,
            };
            res.add(sugMap);
            break;
          case "worstSellingCategory":
            String sales = statsDto.suggestions[key].keys.first;
            String category = statsDto.suggestions[key][sales];
            String suggestion =
                "With $sales sales, $category is not a popular category";
            Map<String, String> sugMap = {
              'Negative': suggestion,
            };
            res.add(sugMap);
            break;
          case "mostReturns":
            String returns = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][returns]["name"];
            String suggestion =
                "$itemName has had $returns returns. This is your most returned item.";
            Map<String, String> sugMap = {
              'Negative': suggestion,
            };
            res.add(sugMap);
            break;
        }
      }
    }
    return res;
  }
}
