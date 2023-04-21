import 'package:flutter/material.dart';

class AuthPagesRouter {
  static double _directionOfTransition(bool fromLeft) => fromLeft ? -1.0 : 1.0;

  static Route createRoute(Widget page, {bool fromLeft = true}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(_directionOfTransition(fromLeft), 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
