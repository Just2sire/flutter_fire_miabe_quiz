import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";

const _iconMap = <String, IconData>{
  // Matières (assets/data/subjects.json)
  "calculator":     LucideIcons.calculator,
  "flask":          LucideIcons.flaskConical,
  "atom":           LucideIcons.atom,
  "dna":            LucideIcons.dna,
  "language":       LucideIcons.languages,
  "languages":      LucideIcons.languages,
  "landmark":       LucideIcons.landmark,
  "globe":          LucideIcons.globe,
  "cpu":            LucideIcons.cpu,

  // Catégories
  "graduation-cap": LucideIcons.graduationCap,
  "briefcase":      LucideIcons.briefcase,
  "hammer":         LucideIcons.hammer,

  // Secteurs
  "monitor":        LucideIcons.monitor,
  "stethoscope":    LucideIcons.stethoscope,
  "hard-hat":       LucideIcons.hardHat,
  "sprout":         LucideIcons.sprout,
  "scale":          LucideIcons.scale,
  "book-open":      LucideIcons.bookOpen,

  // Métiers
  "code-2":         LucideIcons.code2,
  "shield-check":   LucideIcons.shieldCheck,
  "baby":           LucideIcons.baby,
  "wrench":         LucideIcons.wrench,

  // Séries
  "book":           LucideIcons.book,
  "flask-conical":  LucideIcons.flaskConical,
  "package":        LucideIcons.package,
  "bar-chart-3":    LucideIcons.barChart3,
  "trending-up":    LucideIcons.trendingUp,
  "zap":            LucideIcons.zap,
  "building-2":     LucideIcons.building2,
  "waves":          LucideIcons.waves,
  "cog":            LucideIcons.cog,
  "layers":         LucideIcons.layers,
};

IconData resolveIcon(String? name, {IconData fallback = LucideIcons.circle}) {
  if (name == null || name.isEmpty) return fallback;
  return _iconMap[name] ?? fallback;
}
