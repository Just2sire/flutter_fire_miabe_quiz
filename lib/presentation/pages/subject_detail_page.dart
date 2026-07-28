import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:miabe_quiz/core/theme/app_colors.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/domain/entities/index.dart";
import "package:miabe_quiz/presentation/providers/subjects_provider.dart";
import "package:miabe_quiz/presentation/widgets/index.dart"
    show AppScaffold, AppTopbar, SubjectLessonsTab, SubjectQuizzesTab;
import "package:provider/provider.dart";

class SubjectDetailPage extends StatefulWidget {
  const SubjectDetailPage({required this.subjectId, super.key});

  final String subjectId;

  @override
  State<SubjectDetailPage> createState() => _SubjectDetailPageState();
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  Subject? _subject;
  List<Lesson> _lessons = [];
  List<Quiz> _quizzes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = context.read<SubjectsProvider>();
    final subject = await provider.getSubjectById(widget.subjectId);
    final lessons = await provider.lessonsForSubject(widget.subjectId);
    final quizzes = await provider.quizzesForSubject(widget.subjectId);

    if (mounted) {
      setState(() {
        _subject = subject;
        _lessons = lessons;
        _quizzes = quizzes;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AppScaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _subject == null
          ? Center(
              child: Text("Matière introuvable", style: textTheme.titleMedium),
            )
          : DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  AppTopbar(title: _subject!.name),
                  const TabBar(
                    tabs: [
                      Tab(icon: Icon(LucideIcons.bookOpen), text: "Leçons"),
                      Tab(icon: Icon(LucideIcons.helpCircle), text: "Quiz"),
                    ],
                  ),
                  AppSpacing.gapVSm,
                  Expanded(
                    child: TabBarView(
                      children: [
                        SubjectLessonsTab(lessons: _lessons),
                        SubjectQuizzesTab(quizzes: _quizzes),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
