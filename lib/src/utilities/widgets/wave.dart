import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InStockWave extends StatelessWidget {
  const InStockWave({super.key});

  @override
  Widget build(BuildContext context) {
    const String waveSvgPath = 'lib/src/images/svgs/welcome_wave.svg';
    final Widget waveSvg = SvgPicture.asset(
      waveSvgPath,
      fit: BoxFit.cover,
    );

    return (waveSvg);
  }
}
