import 'package:flutter/material.dart';

class PageRouteAnimation extends PageRouteBuilder {
  final Widget page;
  final bool swipeLeft;
  PageRouteAnimation({required this.page, this.swipeLeft = false})
      : super(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = swipeLeft ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
