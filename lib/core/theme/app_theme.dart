import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "app_colors.dart";
import "app_spacing.dart";
import "app_text_styles.dart";

class AppTheme {
  const AppTheme._();

  // ─────────────────────────────────────────────
  // FONTS
  // ─────────────────────────────────────────────

  static const String fontFamily = AppTextStyles.fontFamily;

  // ─────────────────────────────────────────────
  // SHAPES
  // ─────────────────────────────────────────────

  static const shapeLarge = RoundedRectangleBorder(
    borderRadius: AppSpacing.roundedXxl,
  );
  static const shapeMedium = RoundedRectangleBorder(
    borderRadius: AppSpacing.roundedLg,
  );
  static const shapeSmall = RoundedRectangleBorder(
    borderRadius: AppSpacing.roundedMd,
  );

  // -----------------------------------------------------------------------
  // COULEURS (ColorScheme)
  // -----------------------------------------------------------------------
  // Light : fond pêche, CTA vert profond, accent vert vif.
  // Dark  : fond noir, CTA vert vif, accent pêche.
  // -----------------------------------------------------------------------
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.ink,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.surface,
    onSurface: AppColors.ink,
    surfaceContainer: AppColors.surfaceContainer,
    onSurfaceVariant: AppColors.ink54,
    outline: AppColors.neutral300,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.secondary,
    onPrimary: AppColors.white,
    secondary: AppColors.accentAmber,
    onSecondary: AppColors.ink,
    tertiary: AppColors.primary,
    onTertiary: AppColors.paleMint,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.darkBackground,
    onSurface: AppColors.paleMint,
    surfaceContainer: AppColors.darkSurface,
    onSurfaceVariant: AppColors.paleMint54,
    outline: AppColors.neutral600,
  );

  // ─────────────────────────────────────────────
  // LIGHT THEME
  // ─────────────────────────────────────────────

  static final lightTheme = ThemeData(
    fontFamily: fontFamily,

    brightness: Brightness.light,

    // -----------------------------------------------------------------------
    // COULEURS (ColorScheme)
    // -----------------------------------------------------------------------
    colorScheme: lightColorScheme,

    // Text theme
    textTheme: AppTextStyles.lightTextTheme.apply(
      fontFamily: fontFamily,
      bodyColor: lightColorScheme.onSurface,
      displayColor: lightColorScheme.onSurface,
    ),

    // -----------------------------------------------------------------------
    // AppBar
    // -----------------------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.surface,
      foregroundColor: lightColorScheme.onSurface,
      elevation: AppSpacing.elevationNone,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: lightColorScheme.onSurface,
        letterSpacing: 0.5,
        fontFamily: fontFamily,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

    // -----------------------------------------------------------------------
    // Buttons
    // -----------------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        elevation: AppSpacing.elevationMd,
        shadowColor: lightColorScheme.primary.withValues(alpha: 0.4),
        minimumSize: const Size(0, AppSpacing.buttonHeightLg),
        shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: fontFamily,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: lightColorScheme.primary,
        side: BorderSide(color: lightColorScheme.primary, width: 2),
        minimumSize: const Size(0, AppSpacing.buttonHeightLg),
        shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          fontFamily: fontFamily,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightColorScheme.primary,
        minimumSize: const Size(0, AppSpacing.buttonHeightLg),
        shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedMd),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    // -----------------------------------------------------------------------
    // Input Decoration (TextField)
    // -----------------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightInput,
      contentPadding: AppSpacing.inputPadding,
      border: const OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide(
          color: lightColorScheme.primary,
          width: AppSpacing.borderWidthThick,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide(
          color: lightColorScheme.error,
          width: AppSpacing.borderWidthMedium,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide(
          color: lightColorScheme.error,
          width: AppSpacing.borderWidthThick,
        ),
      ),
      labelStyle: TextStyle(
        color: lightColorScheme.onSurfaceVariant,
        fontFamily: fontFamily,
      ),
      hintStyle: const TextStyle(
        color: AppColors.neutral500,
        fontFamily: fontFamily,
      ),
    ),

    // -----------------------------------------------------------------------
    // Card
    // -----------------------------------------------------------------------
    cardTheme: CardThemeData(
      color: lightColorScheme.surfaceContainer,
      elevation: AppSpacing.elevationNone,
      shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedXl),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shadowColor: Colors.black.withValues(alpha: 0.07),
    ),

    // -----------------------------------------------------------------------
    // FloatingActionButton
    // -----------------------------------------------------------------------
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
      elevation: AppSpacing.md,
      shape: const CircleBorder(),
    ),

    // -----------------------------------------------------------------------
    // Bottom Navigation Bar
    // -----------------------------------------------------------------------
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: .fixed,
      elevation: AppSpacing.elevationLg,
      selectedItemColor: lightColorScheme.primary,
      unselectedItemColor: lightColorScheme.onSurface.withValues(alpha: .5),
      selectedLabelStyle: AppTextStyles.lightTextTheme.labelMedium,
      unselectedLabelStyle: AppTextStyles.lightTextTheme.labelSmall,
    ),

    // -----------------------------------------------------------------------
    // Dialog
    // -----------------------------------------------------------------------
    dialogTheme: DialogThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.roundedLg,
      ),
      titleTextStyle: AppTextStyles.lightTextTheme.titleLarge,
      contentTextStyle: AppTextStyles.lightTextTheme.bodyMedium,
    ),

    // -----------------------------------------------------------------------
    // SnackBar
    // -----------------------------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: AppTextStyles.lightTextTheme.bodyMedium,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.roundedMd,
      ),
    ),

    // -----------------------------------------------------------------------
    // Chip
    // -----------------------------------------------------------------------
    chipTheme: ChipThemeData(
      selectedColor: lightColorScheme.primary.withValues(alpha: .1),
      secondarySelectedColor: lightColorScheme.secondary.withValues(alpha: .1),
      labelStyle: AppTextStyles.lightTextTheme.labelMedium,
      shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedMd),
    ),

    // -----------------------------------------------------------------------
    // Autres composants
    // -----------------------------------------------------------------------
    iconTheme: IconThemeData(
      color: lightColorScheme.primary,
      size: AppSpacing.iconLg,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: lightColorScheme.primary,
      circularTrackColor: AppColors.neutral200,
    ),

    dividerTheme: const DividerThemeData(
      thickness: AppSpacing.dividerThickness,
      space: AppSpacing.dividerThickness,
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightColorScheme.primary;
        }
        return AppColors.neutral400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightColorScheme.primary.withValues(alpha: .5);
        }
        return Colors.transparent;
      }),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightColorScheme.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.white),
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.roundedXs,
      ),
    ),

    // Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return lightColorScheme.primary;
        }
        return AppColors.neutral400;
      }),
    ),
  );

  // ─────────────────────────────────────────────
  // DARK THEME
  // ─────────────────────────────────────────────

  static final darkTheme = ThemeData(
    fontFamily: fontFamily,

    brightness: Brightness.dark,

    // -----------------------------------------------------------------------
    // COULEURS (ColorScheme)
    // -----------------------------------------------------------------------
    colorScheme: darkColorScheme,

    // Text theme
    textTheme: AppTextStyles.darkTextTheme.apply(
      fontFamily: fontFamily,
      bodyColor: darkColorScheme.onSurface,
      displayColor: darkColorScheme.onSurface,
    ),

    // -----------------------------------------------------------------------
    // AppBar
    // -----------------------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: darkColorScheme.surface,
      foregroundColor: darkColorScheme.onSurface,
      elevation: AppSpacing.elevationNone,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darkColorScheme.onSurface,
        letterSpacing: 0.5,
        fontFamily: fontFamily,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    // -----------------------------------------------------------------------
    // Buttons
    // -----------------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        elevation: AppSpacing.elevationMd,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        minimumSize: const Size(0, AppSpacing.buttonHeightLg),
        shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
          fontFamily: fontFamily,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: darkColorScheme.primary,
        side: BorderSide(color: darkColorScheme.primary, width: 2),
        minimumSize: const Size(0, AppSpacing.buttonHeightLg),
        shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          fontFamily: fontFamily,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkColorScheme.secondary,
        minimumSize: const Size(0, AppSpacing.buttonHeightLg),
        shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    // -----------------------------------------------------------------------
    // Input Decoration (TextField)
    // -----------------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInput,
      contentPadding: AppSpacing.inputPadding,
      border: const OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide(
          color: darkColorScheme.primary,
          width: AppSpacing.borderWidthThick,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide(
          color: darkColorScheme.error,
          width: AppSpacing.borderWidthMedium,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedLg,
        borderSide: BorderSide(
          color: darkColorScheme.error,
          width: AppSpacing.borderWidthThick,
        ),
      ),
      labelStyle: const TextStyle(
        color: AppColors.paleMint70,
        fontFamily: fontFamily,
      ),
      hintStyle: const TextStyle(
        color: AppColors.paleMint38,
        fontFamily: fontFamily,
      ),
    ),

    // -----------------------------------------------------------------------
    // Card
    // -----------------------------------------------------------------------
    cardTheme: CardThemeData(
      color: darkColorScheme.surfaceContainer,
      elevation: AppSpacing.elevationNone,
      shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedXl),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shadowColor: Colors.black.withValues(alpha: 0.2),
    ),

    // -----------------------------------------------------------------------
    // FloatingActionButton
    // -----------------------------------------------------------------------
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkColorScheme.secondary,
      foregroundColor: darkColorScheme.onSecondary,
      elevation: AppSpacing.md,
      shape: const CircleBorder(),
    ),

    // -----------------------------------------------------------------------
    // Bottom Navigation Bar
    // -----------------------------------------------------------------------
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: .fixed,
      elevation: AppSpacing.elevationLg,
      selectedItemColor: darkColorScheme.primary,
      unselectedItemColor: AppColors.paleMint.withValues(alpha: .5),
      selectedLabelStyle: AppTextStyles.darkTextTheme.labelMedium,
      unselectedLabelStyle: AppTextStyles.darkTextTheme.labelSmall,
    ),

    // -----------------------------------------------------------------------
    // Dialog
    // -----------------------------------------------------------------------
    dialogTheme: DialogThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.roundedLg,
      ),
      titleTextStyle: AppTextStyles.darkTextTheme.titleLarge,
      contentTextStyle: AppTextStyles.darkTextTheme.bodyMedium,
    ),

    // -----------------------------------------------------------------------
    // SnackBar
    // -----------------------------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: AppTextStyles.darkTextTheme.bodyMedium,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.roundedMd,
      ),
    ),

    // -----------------------------------------------------------------------
    // Chip
    // -----------------------------------------------------------------------
    chipTheme: ChipThemeData(
      selectedColor: darkColorScheme.secondary.withValues(alpha: .1),
      secondarySelectedColor: darkColorScheme.primary.withValues(alpha: .1),
      labelStyle: AppTextStyles.darkTextTheme.labelMedium,
      shape: const RoundedRectangleBorder(borderRadius: AppSpacing.roundedMd),
    ),

    // -----------------------------------------------------------------------
    // Autres composants
    // -----------------------------------------------------------------------
    iconTheme: const IconThemeData(
      color: AppColors.paleMint,
      size: AppSpacing.iconMd,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: darkColorScheme.primary,
      circularTrackColor: AppColors.darkSurface,
    ),

    dividerTheme: const DividerThemeData(
      thickness: AppSpacing.dividerThickness,
      space: AppSpacing.dividerThickness,
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return darkColorScheme.primary;
        }
        return AppColors.paleMint54;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return darkColorScheme.primary.withValues(alpha: .5);
        }
        return Colors.transparent;
      }),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return darkColorScheme.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.white),
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.roundedXs,
      ),
    ),

    // Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return darkColorScheme.primary;
        }
        return AppColors.paleMint54;
      }),
    ),
  );
}
