import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:miabe_quiz/core/extensions/build_context_extensions.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/presentation/widgets/app_responsive_builder.dart";
import "package:miabe_quiz/presentation/widgets/app_text_form_field.dart";
import "package:miabe_quiz/presentation/widgets/app_topbar.dart";
import "package:miabe_quiz/presentation/widgets/index.dart" show AppScaffold;

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
                onPressed: () {},
                icon: const Badge(
                  // label: Text("2"),
                  child: Icon(LucideIcons.bell, size: AppSpacing.iconLg),
                ),
                tooltip: "Notifications",
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
                child: ResponsiveLayout(
                  builder: (type) {
                    final isMobile = type == .mobile;
                    return Container(
                      padding: isMobile
                          ? AppSpacing.insetLg
                          : AppSpacing.insetXxxl,
                      decoration: BoxDecoration(
                        borderRadius: AppSpacing.roundedXxl,
                        color: colorScheme.onPrimary,
                      ),
                      child: Column(
                        spacing: isMobile ? AppSpacing.sm : AppSpacing.xxl,
                        crossAxisAlignment: .start,
                        children: [
                          Container(
                            padding: AppSpacing.insetMd,
                            decoration: BoxDecoration(
                              shape: .circle,
                              color: theme.scaffoldBackgroundColor,
                            ),
                            child: Icon(icon),
                          ),
                          Text(label, style: textTheme.bodyLarge),
                          Text(
                            value.toString(),
                            style: textTheme.titleLarge!.copyWith(
                              fontWeight: .bold,
                            ),
                          ),
                        ],
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
              Text("Quiz", style: textTheme.headlineMedium,),
              TextButton(onPressed: () {}, child: const Text("Voir tout"))
            ],
          ),
        ],
      ),
    );
  }
}

typedef _CardData = ({IconData icon, String label, num value});
