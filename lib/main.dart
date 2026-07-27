import "package:flutter/material.dart";
import "package:miabe_quiz/core/routing/router.dart";
import "package:miabe_quiz/core/theme/app_theme.dart";
import "package:miabe_quiz/data/repositories/index.dart";
import "package:miabe_quiz/domain/repositories/index.dart";
import "package:miabe_quiz/presentation/providers/index.dart";
import "package:provider/provider.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ── Repositories (domain-first : exposés par leur interface) ──
        Provider<SubjectRepository>(create: (_) => SubjectRepositoryImpl()),
        Provider<QuestionRepository>(create: (_) => QuestionRepositoryImpl()),
        Provider<QuizRepository>(create: (_) => QuizRepositoryImpl()),
        Provider<BoxRepository>(create: (_) => BoxRepositoryImpl()),
        Provider<StudentRepository>(create: (_) => StudentRepositoryImpl()),

        // ── Providers applicatifs (ChangeNotifier) ──
        ChangeNotifierProvider(create: (_) => ThemeProvider()..load()),
        ChangeNotifierProvider(
          create: (ctx) =>
              SubjectsProvider(ctx.read<SubjectRepository>())..loadSubjects(),
        ),
        ChangeNotifierProvider(
          create: (ctx) =>
              StudentProvider(ctx.read<StudentRepository>())..load(),
        ),
        ChangeNotifierProvider(
          create: (ctx) =>
              BoxesProvider(ctx.read<BoxRepository>())..loadBoxes(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.mode,
      routerConfig: appRouter,
    );
  }
}
