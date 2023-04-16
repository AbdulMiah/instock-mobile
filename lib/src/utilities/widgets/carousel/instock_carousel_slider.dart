import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/utilities/widgets/carousel/positive_slide.dart';
import 'package:instock_mobile/src/utilities/widgets/carousel/share_slide.dart';

import '../../../theme/common_theme.dart';
import '../../data/carousel_dto.dart';
import '../../data/slide_types_enum.dart';
import 'negative_slide.dart';

class InstockCarouselSlider extends StatefulWidget {
  final List<CarouselDto> carouselData;

  const InstockCarouselSlider({Key? key, required this.carouselData})
      : super(key: key);

  @override
  _InstockCarouselSliderState createState() => _InstockCarouselSliderState();
}

class _InstockCarouselSliderState extends State<InstockCarouselSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            enableInfiniteScroll: widget.carouselData.length > 1 ? true : false,
            scrollPhysics: widget.carouselData.length > 1
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
          ),
          items: widget.carouselData.map((carouselDto) {
            if (carouselDto.slideType == SlideTypes.positive) {
              return PositiveSlide(suggestionText: carouselDto.suggestionText);
            } else if (carouselDto.slideType == SlideTypes.negative) {
              return NegativeSlide(suggestionText: carouselDto.suggestionText);
            } else if (carouselDto.slideType == SlideTypes.share) {
              return ShareSlide(suggestionText: carouselDto.suggestionText);
            } else {
              return NegativeSlide(
                  suggestionText: "Whoops something went wrong");
            }
          }).toList(),
        ),
        // reference - indicator for carousel
        // taken from https://github.com/Rapid-Technology/flutter_carousel_slider/blob/master/lib/CarouselWithDotsPage.dart
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.carouselData.asMap().entries.map((entry) {
            int index = entry.key;
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
}
