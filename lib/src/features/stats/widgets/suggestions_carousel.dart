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
          Map<String, String>? sugMap;
          switch (key) {
            case "bestSellingItem":
              sugMap = _bestSellingItem(statsDto.suggestions[key]);
              break;
            case "worstSellingItem":
              sugMap = _worstSellingItem(statsDto.suggestions[key]);
              break;
            case "itemToRestock":
              sugMap = _itemToRestock(statsDto.suggestions[key]);
              break;
            case "longestNoSales":
              sugMap = _longestNoSales(statsDto.suggestions[key]);
              break;
            case "bestSellingCategory":
              sugMap = _bestSellingCategory(statsDto.suggestions[key]);
              break;
            case "worstSellingCategory":
              sugMap = _worstSellingCategory(statsDto.suggestions[key]);
              break;
            case "mostReturns":
              sugMap = _mostReturns(statsDto.suggestions[key]);
              break;
          }
          if (sugMap != null) {
            res.add(sugMap);
          }
        }
      }
    }
    return res;
  }

  Map<String, String>? _bestSellingItem(Map<String, dynamic> data) {
    String sales = data.keys.first;
    if (data[sales] != null) {
      String itemName = data[sales]["name"];
      String suggestion = "With $sales sales, $itemName is your best seller!";
      return {'Positive': suggestion};
    }
    return null;
  }

  Map<String, String>? _worstSellingItem(Map<String, dynamic> data) {
    String sales = data.keys.first;
    if (data[sales] != null) {
      String itemName = data[sales]["name"];
      String suggestion = "With $sales sales, $itemName is your worst seller";
      return {'Negative': suggestion};
    }
    return null;
  }

  Map<String, String>? _itemToRestock(Map<String, dynamic> data) {
    String ratio = data.keys.first;
    if (data[ratio] != null) {
      String itemName = data[ratio]["name"];
      String suggestion =
          "$itemName is flying off the shelves! We predict this will be "
          "your next item to run out of stock. Better restock soon!";
      return {'Positive': suggestion};
    }
    return null;
  }

  Map<String, String>? _longestNoSales(Map<String, dynamic> data) {
    String days = data.keys.first;
    if (data[days] != null) {
      String itemName = data[days]["name"];
      String suggestion =
          "$itemName hasn't sold in $days. People don't know what they're missing!";
      return {'Negative': suggestion};
    }
    return null;
  }

  Map<String, String>? _bestSellingCategory(Map<String, dynamic> data) {
    String sales = data.keys.first;
    if (data[sales] != null) {
      String category = data[sales];
      String suggestion =
          "With $sales sales, $category is your best selling category!";
      return {'Positive': suggestion};
    }
    return null;
  }

  Map<String, String>? _worstSellingCategory(Map<String, dynamic> data) {
    String sales = data.keys.first;
    if (data[sales] != null && data[sales] != "No Categories Found") {
      String category = data[sales];
      String suggestion =
          "With $sales sales, $category is not a popular category";
      return {'Negative': suggestion};
    }
    return null;
  }

  Map<String, String>? _mostReturns(Map<String, dynamic> data) {
    String returns = data.keys.first;
    if (data[returns] != null) {
      String itemName = data[returns]["name"];
      String suggestion =
          "$itemName has had $returns returns. This is your most returned item";
      return {'Negative': suggestion};
    }
    return null;
  }
}
