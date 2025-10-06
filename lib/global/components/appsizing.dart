import 'package:flutter/material.dart';

class AppSizing {
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static SizedBox k20(BuildContext context) =>
      SizedBox(height: height(context) * 0.02);

  /// Returns a vertical SizedBox whose height is a factor of the screen width.
  /// Example: if the screen width is 400 and factor is 0.05, the spacer is 20 logical pixels tall.
  /// This helps in keeping vertical spacing proportional to the width of the screen, which can be useful for responsive UIs.
  static SizedBox khSpacer(BuildContext context, double factor) =>
      SizedBox(height: width(context) * factor);
}
