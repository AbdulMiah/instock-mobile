import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeAnimation extends StatelessWidget {
  const WelcomeAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('lib/src/images/animations/welcome_animation.json'),
    );
  }
}
