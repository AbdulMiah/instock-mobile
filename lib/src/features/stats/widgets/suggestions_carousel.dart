import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/stats/data/stats_dto.dart';

import '../../../theme/common_theme.dart';

class SuggestionsCarousel extends StatefulWidget {
  final StatsDto statsDto;

  const SuggestionsCarousel({super.key, required this.statsDto});

  @override
  State<SuggestionsCarousel> createState() => _SuggestionsCarouselState();
}

class _SuggestionsCarouselState extends State<SuggestionsCarousel> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    List<Map<String, String>> suggestionsMaps =
        extractSuggestions(widget.statsDto);

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
          items: suggestionsMaps.map((i) {
            return Builder(
              builder: (BuildContext context) {
                String positiveOrNegative = i.keys.first;
                String suggestionText = i.values.first;
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: positiveOrNegative == ('Positive')
                          ? theme.themeData.splashColor
                          : suggestionText == ('Negative')
                              ? theme.themeData.cardColor
                              : theme.themeData.cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Text(
                            suggestionText,
                            textAlign: TextAlign.center,
                            style: positiveOrNegative == 'Positive'
                                ? theme.themeData.textTheme.displaySmall?.merge(
                                    const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                                : theme.themeData.textTheme.bodySmall?.merge(
                                    const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Icon(
                            positiveOrNegative == 'Positive'
                                ? Icons.sentiment_very_satisfied
                                : Icons.insert_chart,
                            size: 40,
                            color: positiveOrNegative == 'Positive'
                                ? theme.themeData.primaryColorLight
                                : theme.themeData.primaryColorDark,
                          ),
                        ),
                      ],
                    ));
              },
            );
          }).toList(),
        ),
        // reference - indicator for carousel
        // taken from https://github.com/Rapid-Technology/flutter_carousel_slider/blob/master/lib/CarouselWithDotsPage.dart
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: suggestionsMaps.map((url) {
            int index = suggestionsMaps.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? const Color.fromRGBO(0, 0, 0, 0.9)
                    : const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
        // end of reference
      ],
    );
  }

  List<Map<String, String>> extractSuggestions(StatsDto statsDto) {
    List<Map<String, String>> res = [];
    for (var key in statsDto.suggestions.keys) {
      print("key: $key");
      if (statsDto.suggestions[key] != null) {
        // if there is a suggestion
        if (statsDto.suggestions[key].length > 0) {
          switch (key) {
            case "bestSellingItem":
              String sales = statsDto.suggestions[key].keys.first;
              if (statsDto.suggestions[key][sales] != null) {
                String itemName = statsDto.suggestions[key][sales]["name"];
                String suggestion =
                    "With $sales sales, $itemName is your best seller!";
                Map<String, String> sugMap = {
                  'Positive': suggestion,
                };
                res.add(sugMap);
              }
              break;
            case "worstSellingItem":
              String sales = statsDto.suggestions[key].keys.first;
              if (statsDto.suggestions[key][sales] != null) {
                String itemName = statsDto.suggestions[key][sales]["name"];
                String suggestion =
                    "With $sales sales, $itemName is your worst seller";
                Map<String, String> sugMap = {
                  'Negative': suggestion,
                };
                res.add(sugMap);
              }

              break;
            case "itemToRestock":
              String ratio = statsDto.suggestions[key].keys.first;
              if (statsDto.suggestions[key][ratio] != null) {
                String itemName = statsDto.suggestions[key][ratio]["name"];
                String suggestion =
                    "$itemName is flying off the shelves! We predict this will be "
                    "your next item to run out of stock. Better restock soon!";
                Map<String, String> sugMap = {
                  'Positive': suggestion,
                };
                res.add(sugMap);
              }
              break;
            case "longestNoSales":
              String days = statsDto.suggestions[key].keys.first;
              if (statsDto.suggestions[key][days] != null) {
                String itemName = statsDto.suggestions[key][days]["name"];
                String suggestion =
                    "$itemName hasn't sold in $days. People don't know what they're missing!";
                Map<String, String> sugMap = {
                  'Negative': suggestion,
                };
                res.add(sugMap);
              }
              break;
            case "bestSellingCategory":
              String sales = statsDto.suggestions[key].keys.first;
              if (statsDto.suggestions[key][sales] != null) {
                String category = statsDto.suggestions[key][sales];
                String suggestion =
                    "With $sales sales, $category is your best selling category!";
                Map<String, String> sugMap = {
                  'Positive': suggestion,
                };
                res.add(sugMap);
              }
              break;
            case "worstSellingCategory":
              String sales = statsDto.suggestions[key].keys.first;
              if (statsDto.suggestions[key][sales] != null &&
                  statsDto.suggestions[key][sales] != "No Categories Found") {
                String category = statsDto.suggestions[key][sales];
                String suggestion =
                    "With $sales sales, $category is not a popular category";
                Map<String, String> sugMap = {
                  'Negative': suggestion,
                };
                res.add(sugMap);
              }
              break;
            case "mostReturns":
              String returns = statsDto.suggestions[key].keys.first;
              if (statsDto.suggestions[key][returns]["name"] != null) {
                String itemName = statsDto.suggestions[key][returns]["name"];
                String suggestion =
                    "$itemName has had $returns returns. This is your most returned item.";
                Map<String, String> sugMap = {
                  'Negative': suggestion,
                };
                res.add(sugMap);
              }
              break;
          }
        }
      }
    }
    return res;
  }
}
