import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('lib/src/images/animations/loading_spinner.json'),
    );
  }
}
