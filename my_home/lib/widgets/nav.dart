import 'package:flutter/material.dart';

class Nav {
  static const opacityCurve = const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static push(BuildContext context, Widget child) {
    return Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.decelerate;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }

  static pushReplacement(BuildContext context, Widget child) {
    return Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.decelerate;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }

  static materialPush(BuildContext context, Widget child) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => child,
        ));
  }

  static materialPushReplacement(BuildContext context, Widget child) {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => child,
        ));
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }
}
