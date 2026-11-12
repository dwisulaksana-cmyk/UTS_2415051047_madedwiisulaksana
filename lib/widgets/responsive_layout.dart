import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget compactBody;
  final Widget wideBody;

  const ResponsiveLayout({
    super.key,
    required this.compactBody,
    required this.wideBody,
  });

  static bool isCompact(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  static int getGridCrossAxisCount(double maxWidth) {
    if (maxWidth >= 900) {
      return 3; // Desktop / Wide Tablet
    } else if (maxWidth >= 600) {
      return 2; // Tablet / Landscape HP
    }
    return 1; // Portrait HP (Compact)
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return wideBody;
        }
        return compactBody;
      },
    );
  }
}