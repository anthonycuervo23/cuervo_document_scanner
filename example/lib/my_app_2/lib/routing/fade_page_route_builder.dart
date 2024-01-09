import 'package:flutter/material.dart';

class FadePageRouteBuilder<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  @override
  final RouteSettings settings;

  FadePageRouteBuilder({
    required this.builder,
    required this.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // const begin = Offset(1.0, 0.0);
            // const end = Offset.zero;
            // const curve = Curves.ease;

            // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            // return SlideTransition(
            // position: animation.drive(tween),
            // child: child,
            // );

            var curve = Curves.ease;
            var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
          settings: settings,
        );
}
