import 'package:instock_mobile/src/utilities/data/slide_types_enum.dart';

class CarouselDto {
  final SlideTypes slideType;
  final String suggestionText;

  CarouselDto({
    required this.slideType,
    required this.suggestionText,
  });
}
