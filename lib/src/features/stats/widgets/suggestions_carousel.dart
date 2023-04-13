import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/stats/data/stats_dto.dart';

class SuggestionsCarousel extends StatelessWidget {
  final StatsDto statsDto;

  const SuggestionsCarousel({required this.statsDto});

  @override
  Widget build(BuildContext context) {
    Map<String, String> suggestionsDict = extractSuggestions(statsDto);
    print(suggestionsDict);
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Text(
                  'text $i',
                  style: TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
    );
  }

  Map<String, String> extractSuggestions(StatsDto statsDto) {
    Map<String, String> res = {};
    for (var key in statsDto.suggestions.keys) {
      // print(statsDto.suggestions[key]);
      // if there is a suggestion
      if (statsDto.suggestions[key].length > 0) {
        switch (key) {
          case "bestSellingItem":
            String sales = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][sales]["name"];
            String suggestion =
                "With $sales sales, $itemName is your best seller!";
            res[suggestion] = "Positive";
            break;
          case "worstSellingItem":
            String sales = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][sales]["name"];
            String suggestion =
                "With $sales sales, $itemName is your worst seller";
            res[suggestion] = "Negative";
            break;
          case "itemToRestock":
            String ratio = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][ratio]["name"];
            String suggestion =
                "$itemName is flying off the shelves! We predict this will be "
                "your next item to run out of stock. Better restock soon!";
            res[suggestion] = "Positive";
            break;
          case "longestNoSales":
            String days = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][days]["name"];
            String suggestion =
                "$itemName hasn't sold in $days. People don't know what they're missing!";
            res[suggestion] = "Negative";
            break;
          case "bestSellingCategory":
            String sales = statsDto.suggestions[key].keys.first;
            String category = statsDto.suggestions[key][sales];
            String suggestion =
                "With $sales sales, $category is your best selling category!";
            res[suggestion] = "Positive";
            break;
          case "worstSellingCategory":
            String sales = statsDto.suggestions[key].keys.first;
            String category = statsDto.suggestions[key][sales];
            String suggestion =
                "With $sales sales, $category is not a popular category";
            res[suggestion] = "Negative";
            break;
          case "mostReturns":
            String returns = statsDto.suggestions[key].keys.first;
            String itemName = statsDto.suggestions[key][returns]["name"];
            String suggestion =
                "$itemName has had $returns returns. This is your most returned item.";
            res[suggestion] = "Negative";
            break;
        }
      }
    }
    return res;
  }
}
