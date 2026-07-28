import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:miabe_quiz/core/extensions/build_context_extensions.dart";
import "package:miabe_quiz/core/extensions/string_extensions.dart";
import "package:miabe_quiz/core/theme/app_colors.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/domain/entities/box.dart";
import "package:miabe_quiz/presentation/providers/boxes_provider.dart";
import "package:miabe_quiz/presentation/widgets/countdown_timer.dart";
import "package:miabe_quiz/presentation/widgets/index.dart";
import "package:provider/provider.dart";

class BoxPage extends StatelessWidget {
  const BoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final boxesProvider = context.read<BoxesProvider>();
    return AppScaffold(
      body: Column(
        children: [
          const AppTopbar(title: "Boxes", showLeading: false),
          AppSpacing.gapVMd,
          Expanded(
            child: ListView.builder(
              itemCount: boxesProvider.boxes.length,
              itemBuilder: (context, index) {
                final Box(:id, :remaining, :status, :questionIds) =
                    boxesProvider.boxes[index];
                final controller = CountdownTimerController()
                  ..start(remaining.inSeconds);
                return Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Container(
                    padding: context.isMobile
                        ? AppSpacing.insetLg
                        : AppSpacing.insetXxl,
                    decoration: const BoxDecoration(
                      borderRadius: AppSpacing.roundedXxl,
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Container(
                              padding: context.isMobile
                                  ? AppSpacing.insetSm
                                  : AppSpacing.insetMd,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: context.isDarkMode
                                      ? AppColors.white
                                      : colorScheme.primary,
                                  width: AppSpacing.borderWidthMedium,
                                ),
                                shape: .circle,
                              ),
                              child: Icon(
                                status == .open
                                    ? LucideIcons.packageOpen
                                    : LucideIcons.package2,
                                color: context.isDarkMode
                                    ? AppColors.white
                                    : colorScheme.primary,
                              ),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: context.isMobile
                                    ? AppSpacing.insetSm
                                    : AppSpacing.insetMd,
                                backgroundColor: Colors.grey.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                              color: context.isDarkMode
                                  ? AppColors.white
                                  : colorScheme.primary,
                              onPressed: () {},
                              icon: const Icon(
                                LucideIcons.squareArrowOutUpRight,
                                size: AppSpacing.iconLg,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          crossAxisAlignment: .end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  id.capitalize,
                                  style: textTheme.titleLarge,
                                ),
                                Text(
                                  "${questionIds.length} questions",
                                  style: textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            CountdownTimer(controller: controller),
                          ],
                        ),
                      ],
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
}
