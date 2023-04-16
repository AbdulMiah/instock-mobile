import 'package:flutter/material.dart';
import 'package:instock_mobile/src/utilities/data/carousel_dto.dart';

import '../../../utilities/data/slide_types_enum.dart';
import '../../../utilities/widgets/carousel/instock_carousel_slider.dart';

class MilestonesCarousel extends StatelessWidget {
  MilestonesCarousel({Key? key});

  final List<CarouselDto> milestoneData = [
    // CarouselDto(
    //   slideType: SlideTypes.share,
    //   suggestionText: 'You have a positive milestone',
    // ),
    // CarouselDto(
    //   slideType: SlideTypes.share,
    //   suggestionText: 'You have a negative milestone',
    // ),
    CarouselDto(
      slideType: SlideTypes.share,
      suggestionText: 'You have a share milestone',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return InstockCarouselSlider(carouselData: milestoneData);
  }
}
