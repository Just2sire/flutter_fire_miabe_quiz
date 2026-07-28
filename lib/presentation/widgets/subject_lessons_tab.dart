import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:miabe_quiz/core/extensions/build_context_extensions.dart";
import "package:miabe_quiz/core/theme/app_colors.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/domain/entities/lesson.dart";
import "package:miabe_quiz/presentation/widgets/app_icon_container.dart";

class SubjectLessonsTab extends StatelessWidget {
  const SubjectLessonsTab({required this.lessons, super.key});

  final List<Lesson> lessons;

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return const Center(child: Text("Aucune leçon disponible"));
    }
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) =>
          SubjectLessonCard(lesson: lessons[index]),
    );
  }
}

class SubjectLessonCard extends StatelessWidget {
  const SubjectLessonCard({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        contentPadding: AppSpacing.listItemPaddingSm,
        leading: AppIconContainer(
          backgroundColor: lesson.isCompleted
              ? AppColors.success.withValues(alpha: 0.15)
              : context.colorScheme.primary.withValues(alpha: 0.15),
          color: lesson.isCompleted
              ? AppColors.success
              : context.colorScheme.primary,
          icon: lesson.isCompleted
              ? LucideIcons.checkCircle2
              : LucideIcons.bookOpen,
          iconSize: AppSpacing.iconXl,
        ),
        title: Text(lesson.title, maxLines: 1, overflow: .ellipsis),
        subtitle: Text("${lesson.durationMinutes} min"),
        trailing: lesson.isCompleted
            ? const Icon(LucideIcons.check, color: AppColors.success)
            : const Icon(LucideIcons.chevronRight),
      ),
    );
  }
}
