import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instock_mobile/src/features/stats/services/milestone_service.dart';
import 'package:instock_mobile/src/utilities/widgets/carousel/positive_slide.dart';
import 'package:instock_mobile/src/utilities/widgets/carousel/share_slide.dart';

import '../../../features/stats/data/milestone_dto.dart';
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
  MilestoneService milestoneService = MilestoneService();

  removeMilestone(
      int indexToRemove, String milestoneId, ThemeData themeData) async {
    try {
      MilestoneDto response = await milestoneService.hideMilestone(milestoneId);
      if (response.errorNotificationDto!.hasErrors) {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: themeData.primaryColorLight,
            textColor: themeData.primaryColorDark,
            fontSize: 18.0);
      } else {
        setState(() {
          widget.carouselData.removeAt(indexToRemove);
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: themeData.primaryColorLight,
          textColor: themeData.primaryColorDark,
          fontSize: 18.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    if (widget.carouselData.isEmpty) {
      return Container();
    } else {
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
              enableInfiniteScroll:
                  widget.carouselData.length > 1 ? true : false,
              scrollPhysics: widget.carouselData.length > 1
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
            ),
            items: widget.carouselData.map((carouselDto) {
              if (carouselDto.slideType == SlideTypes.positive) {
                return PositiveSlide(
                    suggestionText: carouselDto.suggestionText);
              } else if (carouselDto.slideType == SlideTypes.negative) {
                return NegativeSlide(
                    suggestionText: carouselDto.suggestionText);
              } else if (carouselDto.slideType == SlideTypes.share) {
                return ShareSlide(
                  suggestionText: carouselDto.suggestionText,
                  milestone: carouselDto.milestone!,
                  hideFunction: () {
                    removeMilestone(_current,
                        carouselDto.milestone!.milestoneId, theme.themeData);
                  },
                );
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
}
