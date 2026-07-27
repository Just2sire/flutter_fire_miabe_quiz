import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:miabe_quiz/core/extensions/build_context_extensions.dart";
import "package:miabe_quiz/core/extensions/string_extensions.dart";
import "package:miabe_quiz/core/helpers/icon_resolver.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/domain/entities/subject.dart" show Subject;
import "package:miabe_quiz/presentation/providers/index.dart";
import "package:miabe_quiz/presentation/widgets/index.dart"
    show AppScaffold, AppTextFormField, AppTopbar;
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  const HomePage({required this.username, super.key});

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<_CardData> cardData = [
    (icon: LucideIcons.notebookPen, label: "Quiz complétés", value: 0),
    (icon: LucideIcons.star, label: "Points total", value: 0),
  ];
  @override
  Widget build(BuildContext context) {
    final username = widget.username;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final subjectProvider = context.read<SubjectsProvider>();

    return AppScaffold(
      padding: context.isMobile
          ? AppSpacing.screenPadding
          : AppSpacing.screenPaddingLg,
      body: Column(
        children: [
          AppTopbar(
            title: username,
            subtitle: "Niveau 10",
            showLeading: false,
            titleSubtitleSpacing: 0,
            actions: [
              IconButton(
                style: IconButton.styleFrom(
                  padding: AppSpacing.insetMd,
                  backgroundColor: colorScheme.onPrimary,
                ),
                color: colorScheme.secondary,
                onPressed: () {},
                icon: const Badge(
                  child: Icon(LucideIcons.bell, size: AppSpacing.iconLg),
                ),
                tooltip: "Notifications",
              ),
              IconButton(
                style: IconButton.styleFrom(
                  padding: AppSpacing.insetMd,
                  backgroundColor: colorScheme.onPrimary,
                ),
                color: colorScheme.secondary,
                onPressed: () => context.read<ThemeProvider>().toggle(),
                icon: Icon(
                  context.watch<ThemeProvider>().isDark
                      ? LucideIcons.moon
                      : LucideIcons.sun,
                  size: AppSpacing.iconLg,
                ),
                tooltip: "Thème",
              ),
            ],
          ),
          AppSpacing.gapVMd,
          AppTextFormField(
            hintText: "Rechercher un sujet",
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: AppSpacing.md),
              child: Icon(LucideIcons.search, size: AppSpacing.iconLg),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: AppSpacing.roundedFull,
            ),
            focusBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.outline),
              borderRadius: AppSpacing.roundedFull,
            ),
          ),
          AppSpacing.gapVMd,
          Row(
            spacing: AppSpacing.lg,
            children: List.generate(2, (index) {
              final (:icon, :label, :value) = cardData[index];
              return Expanded(
                child: Builder(
                  builder: (context) {
                    final isMobile = context.isMobile;
                    return Card(
                      margin: EdgeInsets.zero,
                      child: Container(
                        padding: isMobile
                            ? AppSpacing.insetLg
                            : AppSpacing.insetXxl,
                        decoration: const BoxDecoration(
                          borderRadius: AppSpacing.roundedXxl,
                        ),
                        child: isMobile
                            ? Column(
                                spacing: isMobile
                                    ? AppSpacing.sm
                                    : AppSpacing.xxl,
                                crossAxisAlignment: .start,
                                children: [
                                  Container(
                                    padding: AppSpacing.insetMd,
                                    decoration: BoxDecoration(
                                      shape: .circle,
                                      color: theme.scaffoldBackgroundColor,
                                    ),
                                    child: Icon(
                                      icon,
                                      color: colorScheme.secondary,
                                    ),
                                  ),
                                  Text(label, style: textTheme.bodyLarge),
                                  Text(
                                    value.toString(),
                                    style: textTheme.titleLarge!.copyWith(
                                      fontWeight: .bold,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Column(
                                    spacing: AppSpacing.sm,
                                    crossAxisAlignment: .start,
                                    children: [
                                      IconContainer(icon: icon),
                                      Text(label, style: textTheme.bodyLarge),
                                    ],
                                  ),
                                  Text(
                                    value.toString(),
                                    style: textTheme.displayMedium!.copyWith(
                                      // fontWeight: .bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          AppSpacing.gapVMd,
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("Quiz", style: textTheme.headlineMedium),
              TextButton(onPressed: () {}, child: const Text("Voir tout")),
            ],
          ),
          SizedBox(
            height: AppSpacing.yotta * 1.5,
            child: ListView(
              scrollDirection: .horizontal,
              children: List.generate(subjectProvider.subjects.length, (index) {
                final Subject(
                  :colorHex,
                  :iconName,
                  :name,
                  :totalLessons,
                  :totalQuizzes,
                ) = subjectProvider.subjects[index];
                return Card(
                  margin: const EdgeInsets.only(right: AppSpacing.lg),
                  color: colorHex.toColor(),
                  child: Container(
                    width: context.isMobile
                        ? context.screenWidth * 0.8
                        : context.screenWidth * 0.3,
                    padding: AppSpacing.insetMd,
                    decoration: const BoxDecoration(
                      borderRadius: AppSpacing.roundedXxl,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconContainer(
                              backgroundColor: colorScheme.surface.withValues(
                                alpha: 0.5,
                              ),
                              color: colorScheme.surface,
                              icon: resolveIcon(iconName),
                            ),
                            Column(
                              children: [
                                Text(name),
                                Text("$totalLessons Cours"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({
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

typedef _CardData = ({IconData icon, String label, num value});
