import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:miabe_quiz/core/extensions/build_context_extensions.dart";
import "package:miabe_quiz/core/theme/app_colors.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/domain/entities/quiz.dart";
import "package:miabe_quiz/presentation/widgets/app_icon_container.dart";
import "package:miabe_quiz/presentation/widgets/app_progress_indicator.dart";

class SubjectQuizzesTab extends StatelessWidget {
  const SubjectQuizzesTab({required this.quizzes, super.key});

  final List<Quiz> quizzes;

  @override
  Widget build(BuildContext context) {
    if (quizzes.isEmpty) {
      return const Center(child: Text("Aucun quiz disponible"));
    }
    return ListView.builder(
      itemCount: quizzes.length,
      itemBuilder: (context, index) => SubjectQuizCard(quiz: quizzes[index]),
    );
  }
}

class SubjectQuizCard extends StatelessWidget {
  const SubjectQuizCard({required this.quiz, super.key});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        contentPadding: AppSpacing.listItemPaddingSm,
        leading: AppIconContainer(
          backgroundColor: context.colorScheme.primary.withValues(alpha: 0.15),
          icon: LucideIcons.helpCircle,
          color: context.colorScheme.primary,
          iconSize: AppSpacing.iconXl,
        ),
        title: Text(quiz.title, maxLines: 1, overflow: .ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${quiz.totalQuestions} questions"),
            // if (quiz.progress > 0) ...[
            //   const SizedBox(height: 4),
            //   AppProgressIndicator(value: quiz.progress),
            // ],
          ],
        ),
        trailing: const Icon(LucideIcons.chevronRight),
      ),
    );
  }
}
