import 'package:flutter/widgets.dart';

/// Material 3 canonical window size classes for Web, Tablet (iPad/Android), and Mobile.
enum ScreenSizeClass { compact, medium, expanded }

abstract final class Breakpoints {
  static const double compactMaxWidth = 600;
  static const double mediumMaxWidth = 1024;
  static const double maxContentWidth = 1200;

  static ScreenSizeClass of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < compactMaxWidth) return ScreenSizeClass.compact;
    if (width < mediumMaxWidth) return ScreenSizeClass.medium;
    return ScreenSizeClass.expanded;
  }

  static bool isMobile(BuildContext context) =>
      of(context) == ScreenSizeClass.compact;

  static bool isTablet(BuildContext context) =>
      of(context) == ScreenSizeClass.medium;

  static bool isDesktopOrWebWide(BuildContext context) =>
      of(context) == ScreenSizeClass.expanded;
}
