import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:miabe_quiz/core/extensions/index.dart";
import "package:miabe_quiz/core/helpers/icon_resolver.dart";
import "package:miabe_quiz/core/theme/app_colors.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/domain/entities/subject.dart";
import "package:miabe_quiz/presentation/widgets/app_text_form_field.dart";
import "package:miabe_quiz/presentation/widgets/index.dart"
    show AppScaffold, AppTopbar, AppIconContainer, AppProgressIndicator;
import "package:provider/provider.dart";

import "../providers/subjects_provider.dart";

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectsProvider>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppScaffold(
      body: Column(
        spacing: AppSpacing.sm,
        children: [
          const AppTopbar(showLeading: false, title: "Matières"),
          AppTextFormField(
            controller: searchController,
            hintText: "Recherche...",
            textInputAction: .search,
            onChanged: (_) => search(),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: IconButton(
                onPressed: search,
                icon: const Icon(LucideIcons.search, size: AppSpacing.iconLg),
              ),
            ),
          ),
          AppSpacing.gapVXs,
          Expanded(
            child: ListView.builder(
              itemCount: subjectProvider.filteredSubjects.length,
              itemBuilder: (context, index) {
                final Subject(
                  :id,
                  :colorHex,
                  :iconName,
                  :name,
                  :totalLessons,
                  :totalQuizzes,
                  :progress,
                ) = subjectProvider.filteredSubjects[index];
                return GestureDetector(
                  onTap: () => context.goToSubjectDetail(id),
                  child: Card(
                    color: colorHex.toColor(),
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Container(
                      height: AppSpacing.yotta * 1.4,
                      alignment: .center,
                      padding: AppSpacing.insetMd,
                      decoration: const BoxDecoration(
                        borderRadius: AppSpacing.roundedXxl,
                      ),
                      child: Column(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Row(
                            spacing: AppSpacing.md,
                            children: [
                              AppIconContainer(
                                backgroundColor: AppColors.white.withValues(
                                  alpha: 0.2,
                                ),
                                color: AppColors.white,
                                iconSize: AppSpacing.iconLg,
                                icon: resolveIcon(iconName),
                              ),
                              Text(
                                name,
                                style: textTheme.titleLarge!.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                style: IconButton.styleFrom(
                                  padding: AppSpacing.insetMd,
                                  backgroundColor: colorScheme.onPrimary,
                                ),
                                color: AppColors.neutral900,
                                onPressed: () => context.goToSubjectDetail(id),
                                icon: const Icon(
                                  LucideIcons.squareArrowOutUpRight,
                                  size: AppSpacing.iconLg,
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.gapVSm,
                          AppProgressIndicator(
                            value: progress,
                            height: AppSpacing.xs,
                            backgroundColor: AppColors.white.withValues(
                              alpha: 0.2,
                            ),
                            valueColor: AppColors.white,
                          ),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Text(
                                "Progrès",
                                style: textTheme.bodyMedium!.copyWith(
                                  color: AppColors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              Text(
                                "${(progress * 100).round()}%",
                                style: textTheme.bodyMedium!.copyWith(
                                  color: AppColors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void search() {
    final query = searchController.text;
    context.read<SubjectsProvider>().setSearchQuery(query);
  }
}
