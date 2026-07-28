import "package:flutter/material.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";

class AppIconContainer extends StatelessWidget {
  const AppIconContainer({
    required this.icon,
    this.iconSize,
    this.backgroundColor,
    this.color,
    this.padding = AppSpacing.insetMd,
    super.key,
  });

  final IconData icon;
  final double? iconSize;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        shape: .circle,
        color: backgroundColor ?? theme.scaffoldBackgroundColor,
      ),
      child: Icon(icon, color: color ?? colorScheme.secondary, size: iconSize),
    );
  }
}
