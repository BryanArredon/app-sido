import 'package:flutter/material.dart';
import '../../core/responsive/breakpoints.dart';

class AdaptiveDestination {
  const AdaptiveDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Adaptive shell that renders:
/// - `NavigationBar` (bottom bar) on Android/iOS phones (< 600px)
/// - `NavigationRail` (compact sidebar) on Tablets (600px - 1024px)
/// - `NavigationRail` (expanded sidebar) on Web / Desktop (>= 1024px)
class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.currentIndex = 0,
    this.onDestinationSelected,
    this.destinations = const [],
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final int currentIndex;
  final ValueChanged<int>? onDestinationSelected;
  final List<AdaptiveDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final sizeClass = Breakpoints.of(context);
    final hasNavigation = destinations.length >= 2;

    final constrainedBody = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.maxContentWidth,
        ),
        child: body,
      ),
    );

    if (sizeClass == ScreenSizeClass.compact || !hasNavigation) {
      return Scaffold(
        appBar: AppBar(title: Text(title), actions: actions),
        body: constrainedBody,
        bottomNavigationBar: hasNavigation
            ? NavigationBar(
                selectedIndex: currentIndex,
                onDestinationSelected: onDestinationSelected,
                destinations: [
                  for (final d in destinations)
                    NavigationDestination(
                      icon: Icon(d.icon),
                      selectedIcon: Icon(d.selectedIcon),
                      label: d.label,
                    ),
                ],
              )
            : null,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: Row(
        children: [
          NavigationRail(
            extended: sizeClass == ScreenSizeClass.expanded,
            selectedIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              for (final d in destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: constrainedBody),
        ],
      ),
    );
  }
}
