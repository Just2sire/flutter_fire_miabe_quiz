// responsive_layout.dart
import "package:flutter/material.dart";
import "package:miabe_quiz/core/extensions/index.dart";

/// Enum représentant le type d'écran courant.
enum ScreenType { mobile, tablet, desktop }

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.builder,
    super.key,
  });

  /// Builder appelé avec le [ScreenType] détecté.
  final Widget Function(ScreenType screenType) builder;

  // ── Helpers statiques ────────────────────────────────────────────────────

  static bool isMobile(BuildContext context) => context.isMobile;

  static bool isTablet(BuildContext context) => context.isTablet;

  static bool isDesktop(BuildContext context) => context.isDesktop;

  /// Retourne le [ScreenType] correspondant au contexte courant.
  static ScreenType screenTypeOf(BuildContext context) {
    if (context.isDesktop) return ScreenType.desktop;
    if (context.isTablet) return ScreenType.tablet;
    return ScreenType.mobile;
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ScreenType screenType;

        if (constraints.maxWidth >= 1100) {
          screenType = ScreenType.desktop;
        } else if (constraints.maxWidth >= 650) {
          screenType = ScreenType.tablet;
        } else {
          screenType = ScreenType.mobile;
        }

        return builder(screenType);
      },
    );
  }
}
