import "package:flutter/cupertino.dart";

/// Palette de couleurs de l'application.
///
/// Identité « Neutre + Accents », inspirée de :
/// - **Primary** (charbon 262626)  → CTA principaux, texte, éléments actifs.
/// - **Background** (crème F3F0EC) → fond général de l'app (light mode).
/// - **White** (blanc pur)          → cartes / surfaces élevées (light mode).
/// - **Accents** (violet, rouge, ambre, vert) → couleurs de catégories/sujets,
///   badges, barres de progression, sélections.
///
/// Le texte n'utilise jamais de noir pur : on lui préfère `ink` (dérivé de
/// primary) en light mode et un blanc cassé chaleureux (`paleMint`) en dark
/// mode, pour garder une teinte cohérente avec le fond crème de la marque.
class AppColors {
  const AppColors._();

  // ───────────────────────────────────────────────
  // BRAND — couleurs de marque
  // ───────────────────────────────────────────────

  /// Charbon — couleur d'ancrage. CTA principaux en light mode,
  /// devient une surface élevée / accent en dark mode.
  static const Color primary = Color(0xFF262626);

  /// Violet — accent principal. Sélections, barres de progression,
  /// liens, CTA en dark mode.
  static const Color secondary = Color(0xFF8157F9);

  /// Crème — fond général du light mode.
  static const Color tertiary = Color(0xFFF3F0EC);

  /// Blanc pur — cartes / surfaces élevées en light mode.
  static const Color white = Color(0xFFFFFFFF);

  // ───────────────────────────────────────────────
  // ACCENTS — couleurs de catégories / sujets
  // ───────────────────────────────────────────────

  static const Color accentPurple = Color(0xFF8157F9);
  static const Color accentRed = Color(0xFFD55E55);
  static const Color accentAmber = Color(0xFFE9AC49);
  static const Color accentGreen = Color(0xFF46855A);

  /// Liste pratique pour assigner une couleur à chaque catégorie/carte
  /// en boucle (ex: `categoryColors[index % categoryColors.length]`).
  static const List<Color> categoryColors = [
    accentPurple,
    accentRed,
    accentAmber,
    accentGreen,
  ];

  // ───────────────────────────────────────────────
  // ÉTATS
  // ───────────────────────────────────────────────

  static const Color error = Color(0xFFD55E55);
  static const Color warning = Color(0xFFE9AC49);
  static const Color success = Color(0xFF46855A);
  static const Color info = Color(0xFF8157F9);

  // ───────────────────────────────────────────────
  // ENCRE & BLANC CASSÉ — couleurs de texte de marque
  // ───────────────────────────────────────────────

  /// Encre charbon — remplace le noir pur pour les textes en light mode.
  static const Color ink = Color(0xFF262626);
  static const Color ink87 = Color(0xDE262626);
  static const Color ink54 = Color(0x8A262626);
  static const Color ink38 = Color(0x61262626);

  /// Blanc cassé chaud — remplace le blanc pur pour les textes en dark mode.
  static const Color paleMint = Color(0xFFF3F0EC);
  static const Color paleMint87 = Color(0xDEF3F0EC);
  static const Color paleMint70 = Color(0xB3F3F0EC);
  static const Color paleMint54 = Color(0x8AF3F0EC);
  static const Color paleMint38 = Color(0x61F3F0EC);

  // ───────────────────────────────────────────────
  // LIGHT MODE — surfaces
  // ───────────────────────────────────────────────

  /// Fond général (scaffold) : crème.
  static const Color surface = Color(0xFFF3F0EC);

  /// Surface élevée (cartes) : blanc pur.
  static const Color surfaceContainer = Color(0xFFFFFFFF);

  /// Champ de saisie.
  static const Color lightInput = Color(0xFFFFFFFF);

  // ───────────────────────────────────────────────
  // DARK MODE — surfaces
  // ───────────────────────────────────────────────

  /// Fond général (scaffold) : quasi-noir.
  static const Color darkBackground = Color(0xFF121212);

  /// Surface élevée (cartes) : charbon (= primary).
  static const Color darkSurface = Color(0xFF262626);

  /// Champ de saisie.
  static const Color darkInput = Color(0xFF2E2E2E);

  // ───────────────────────────────────────────────
  // GRADIENT — couleurs de fond
  // ───────────────────────────────────────────────

  static const goldenGradient = LinearGradient(
    colors: [
      Color(0xFFECC440),
      Color(0xFFFFFA8A),
      Color(0xFFDDAC17),
      Color(0xFFFFFF95),
    ],
  );

  static const fullGoldenGradient = LinearGradient(
    colors: [
      Color(0xFFE8D76B),
      Color(0xFFA6700C),
      Color(0xFFC4921D),
      Color(0xFFE2C55F),
      Color(0xFFC59E38),
    ],
  );

  // ───────────────────────────────────────────────
  // BRAND & SURFACE GRADIENTS
  // ───────────────────────────────────────────────

  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  static const softSurfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [surfaceContainer, surface],
  );

  // ───────────────────────────────────────────────
  // PRIMARY LUSH GRADIENTS (3-STOP+)
  // ───────────────────────────────────────────────

  static const primaryDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF121212),
      Color(0xFF1E1E1E),
      primary,
    ],
  );

  static const primaryLush = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ink, primary, secondary],
  );

  static const primaryDeepLush = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ink, primary, primary],
  );

  static const primaryLightLush = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary, paleMint],
  );

  static const primarySoftLush = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, paleMint, surface],
  );

  // ───────────────────────────────────────────────
  // ACCENT GRADIENTS (catégories / cartes)
  // ───────────────────────────────────────────────

  static const purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentPurple, Color(0xFF6A3FE0)],
  );

  static const redGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentRed, Color(0xFFB94940)],
  );

  static const amberGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentAmber, Color(0xFFCE8F30)],
  );

  static const greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGreen, Color(0xFF35664B)],
  );

  // ───────────────────────────────────────────────
  // SEMANTIC GRADIENTS (PREMIUM)
  // ───────────────────────────────────────────────

  static const successGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [accentGreen, Color(0xFF35664B)],
  );

  static const errorGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [accentRed, Color(0xFFB94940)],
  );

  static const infoGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [accentPurple, Color(0xFF6A3FE0)],
  );

  static const warningGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [accentAmber, Color(0xFFCE8F30)],
  );

  // ───────────────────────────────────────────────
  // NEUTRES — échelle taupe chaude, cohérente avec le crème
  // ───────────────────────────────────────────────

  static const Color neutral50 = Color(0xFFFAF9F7);
  static const Color neutral100 = Color(0xFFF3F0EC);
  static const Color neutral200 = Color(0xFFE6E2DA);
  static const Color neutral300 = Color(0xFFD3CDC1);
  static const Color neutral400 = Color(0xFFAFA79A);
  static const Color neutral500 = Color(0xFF8A8175);
  static const Color neutral600 = Color(0xFF6B6459);
  static const Color neutral700 = Color(0xFF4D473F);
  static const Color neutral800 = Color(0xFF33302A);
  static const Color neutral900 = Color(0xFF1A1817);
}
