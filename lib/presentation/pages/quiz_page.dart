import "package:flutter/material.dart";
import "package:miabe_quiz/core/extensions/navigation_extensions.dart";
import "package:miabe_quiz/presentation/providers/student_provider.dart";
import "package:miabe_quiz/presentation/widgets/app_scaffold.dart";
import "package:miabe_quiz/presentation/widgets/app_topbar.dart";
import "package:provider/provider.dart";

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    final student = context.read<StudentProvider>().student;
    return AppScaffold(
      body: Column(
        children: [
          AppTopbar(
            title: "Quiz",
            onPop: () => context.goToHome(student.fullName),
          ),
        ],
      ),
    );
  }
}
