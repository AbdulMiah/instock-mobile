import 'dart:math';

import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/stats/data/milestone_list_dto.dart';
import 'package:instock_mobile/src/features/stats/services/milestone_service.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:instock_mobile/src/utilities/data/carousel_dto.dart';

import '../../../utilities/data/slide_types_enum.dart';
import '../../../utilities/widgets/carousel/instock_carousel_slider.dart';
import '../data/milestone_dto.dart';

class MilestonesCarousel extends StatelessWidget {
  MilestonesCarousel({Key? key});

  final MilestoneService _milestoneService = MilestoneService();

  String messageGenerator(MilestoneDto milestone) {
    List<String> messages = [
      "${Emojis.partyPopper} Congratulations, ${milestone.itemName} has reached ${milestone.totalSales} sales!",
      "Great news! ${milestone.itemName} just hit ${milestone.totalSales} sales!",
      "Yay! ${milestone.itemName} has sold ${milestone.totalSales} units! ${Emojis.cowboyHatFace} ",
      "Woo! ${Emojis.smilingFaceWithHeartEyes} ${milestone.itemName} has sold ${milestone.totalSales} times!",
      "${milestone.itemName} has hit ${milestone.totalSales} sales! ${Emojis.moneyMouthFace}",
    ];

    int randomIndex = Random().nextInt(messages.length);
    return messages[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = CommonTheme().themeData;
    return FutureBuilder<MilestoneListDto>(
      future: _milestoneService.getMilestones(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Container();
        } else if (!snapshot.hasData) {
          return Container();
        }

        List<CarouselDto> milestoneData = snapshot.data!.milestones
            .map((milestone) => CarouselDto(
                  slideType: SlideTypes.share,
                  suggestionText: messageGenerator(milestone),
                  milestone: milestone,
                ))
            .toList();

        return InstockCarouselSlider(carouselData: milestoneData);
      },
    );
  }
}
