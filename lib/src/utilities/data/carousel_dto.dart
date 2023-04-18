import 'package:instock_mobile/src/utilities/data/slide_types_enum.dart';

import '../../features/stats/data/milestone_dto.dart';

class CarouselDto {
  final SlideTypes slideType;
  final String suggestionText;
  final MilestoneDto? milestone;

  CarouselDto({
    required this.slideType,
    required this.suggestionText,
    this.milestone,
  });
}
