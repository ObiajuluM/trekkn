import 'package:flutter/material.dart';

/// This class allows me to create a custom page transition animation to override the one specified in the theme.pageTransitionsTheme
class PageRouteAnimations {
  ///
  static Route fadeTransitionRoute(Widget page, {int durationMs = 250}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: durationMs),
    );
  }

  /// Add other animation types as needed
  static Route slideTransitionRoute(Widget page, {int durationMs = 300}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: durationMs),
    );
  }
}

class FadePageTransitionsBuilder extends PageTransitionsBuilder {
  // makes the page fade into view
  const FadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // We only use the primary animation for the fade effect.
    // The secondaryAnimation is typically used for the outgoing page's animation,
    // which is not part of a simple fade-in.
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
