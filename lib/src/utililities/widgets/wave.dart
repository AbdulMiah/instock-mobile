import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InStockWave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String WaveSvgPath = 'lib/src/images/svgs/welcome_wave.svg';
    final Widget WaveSvg = SvgPicture.asset(WaveSvgPath);
    return (WaveSvg);
  }
}
