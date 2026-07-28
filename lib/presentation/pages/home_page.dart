import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:miabe_quiz/core/extensions/build_context_extensions.dart";
import "package:miabe_quiz/core/extensions/string_extensions.dart";
import "package:miabe_quiz/core/helpers/icon_resolver.dart";
import "package:miabe_quiz/core/theme/app_colors.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/domain/entities/lesson.dart";
import "package:miabe_quiz/domain/entities/subject.dart" show Subject;
import "package:miabe_quiz/presentation/widgets/index.dart"
    show
        AppScaffold,
        AppTextFormField,
        AppTopbar,
        AppProgressIndicator,
        AppIconContainer;
import "package:provider/provider.dart";

import "../providers/index.dart";

class HomePage extends StatefulWidget {
  const HomePage({required this.username, super.key});

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentProvider>().updateProfile(fullName: widget.username);
      context.read<SubjectsProvider>().loadSubjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final subjectProvider = context.read<SubjectsProvider>();
    final student = context.read<StudentProvider>().student;
    final cardData = <_CardData>[
      (
        icon: LucideIcons.notebookPen,
        label: "Quiz complétés",
        value: student.completedQuizzesCount,
      ),
      (
        icon: LucideIcons.star,
        label: "Points total",
        value: student.totalPoints,
      ),
    ];

    return AppScaffold(
      scrollable: true,
      padding: context.isMobile
          ? AppSpacing.screenPadding
          : AppSpacing.screenPaddingLg,
      body: Column(
        children: [
          AppTopbar(
            // title: student.fullName.split(" ")[-1],
            title: student.fullName,
            subtitle: student.gradeLevel,
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
              return HomeCard(
                theme: theme,
                icon: icon,
                colorScheme: colorScheme,
                label: label,
                textTheme: textTheme,
                value: value,
              );
            }),
          ),
          AppSpacing.gapVMd,
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("Matières", style: textTheme.headlineMedium),
              TextButton(onPressed: () {}, child: const Text("Voir tout")),
            ],
          ),
          SizedBox(
            height: AppSpacing.yotta * 1.65,
            child: ListView.builder(
              scrollDirection: .horizontal,
              itemCount: subjectProvider.subjects.length,
              itemBuilder: (context, index) {
                final Subject(
                  :colorHex,
                  :iconName,
                  :name,
                  :totalLessons,
                  :totalQuizzes,
                  :progress,
                ) = subjectProvider.subjects[index];
                return SubjectCard(
                  colorHex: colorHex,
                  iconName: iconName,
                  name: name,
                  textTheme: textTheme,
                  totalLessons: totalLessons,
                  totalQuizzes: totalQuizzes,
                  progress: progress,
                );
              },
            ),
          ),
          AppSpacing.gapVMd,
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("Math", style: textTheme.headlineMedium),
              TextButton(onPressed: () {}, child: const Text("Voir tout")),
            ],
          ),
          FutureBuilder(
            future: getMathLessons(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == .waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.connectionState == .done && snapshot.hasData) {
                final lessons = snapshot.data!;
                return SizedBox(
                  height: AppSpacing.yotta * 1.825,
                  child: ListView.builder(
                    scrollDirection: .horizontal,
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final Lesson(
                        :unitId,
                        :title,
                        // :thumbnailAsset,
                      ) = lessons[index];
                      return LessonCard(title: title, textTheme: textTheme);
                    },
                  ),
                );
              }

              return const Center(
                child: Text("Erreur lors du chargement des données"),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<List<Lesson>> getMathLessons() async {
    final lessons = await context.read<SubjectsProvider>().lessonsForSubject(
      "math",
    );
    return lessons;
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    required this.theme,
    required this.icon,
    required this.colorScheme,
    required this.label,
    required this.textTheme,
    required this.value,
    super.key,
  });

  final ThemeData theme;
  final IconData icon;
  final ColorScheme colorScheme;
  final String label;
  final TextTheme textTheme;
  final num value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(
        builder: (context) {
          final isMobile = context.isMobile;
          return Card(
            margin: EdgeInsets.zero,
            child: Container(
              padding: isMobile ? AppSpacing.insetLg : AppSpacing.insetXxl,
              decoration: const BoxDecoration(
                borderRadius: AppSpacing.roundedXxl,
              ),
              child: isMobile
                  ? Column(
                      spacing: isMobile ? AppSpacing.sm : AppSpacing.xxl,
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                          padding: AppSpacing.insetMd,
                          decoration: BoxDecoration(
                            shape: .circle,
                            color: theme.scaffoldBackgroundColor,
                          ),
                          child: Icon(icon, color: colorScheme.secondary),
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
                            AppIconContainer(icon: icon),
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
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard({required this.title, required this.textTheme, super.key});

  final String title;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSpacing.elevationMd,
      margin: const EdgeInsets.only(right: AppSpacing.lg),
      child: Container(
        width: context.isMobile
            ? context.screenWidth * 0.6
            : context.screenWidth * 0.25,
        padding: AppSpacing.insetMd,
        decoration: const BoxDecoration(borderRadius: AppSpacing.roundedXl),
        child: Column(
          mainAxisSize: .min,
          spacing: AppSpacing.xs,
          crossAxisAlignment: .start,
          children: [
            Container(
              height: AppSpacing.yotta,
              alignment: .center,
              decoration: const BoxDecoration(
                borderRadius: AppSpacing.roundedLg,
                color: Colors.grey,
              ),
              child: const FlutterLogo(),
            ),
            Text(
              title,
              style: textTheme.bodyMedium,
              maxLines: 2,
              overflow: .ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    required this.colorHex,
    required this.iconName,
    required this.name,
    required this.textTheme,
    required this.totalLessons,
    required this.totalQuizzes,
    required this.progress,
    super.key,
  });

  final String colorHex;
  final String iconName;
  final String name;
  final TextTheme textTheme;
  final int totalLessons;
  final int totalQuizzes;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: AppSpacing.lg),
      color: colorHex.toColor(),
      child: Container(
        width: context.isMobile
            ? context.screenWidth * 0.8
            : context.screenWidth * 0.4,
        padding: AppSpacing.insetMd,
        decoration: const BoxDecoration(borderRadius: AppSpacing.roundedXxl),
        child: Column(
          mainAxisSize: .min,
          spacing: AppSpacing.xs,
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: AppSpacing.md,
              children: [
                AppIconContainer(
                  backgroundColor: AppColors.white.withValues(alpha: 0.2),
                  color: AppColors.white,
                  iconSize: AppSpacing.iconXl,
                  icon: resolveIcon(iconName),
                ),
                Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      name,
                      style: textTheme.titleMedium!.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      "$totalLessons Cours",
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "$totalQuizzes Quiz",
              style: textTheme.titleMedium!.copyWith(color: AppColors.white),
            ),
            AppProgressIndicator(
              value: progress,
              height: AppSpacing.xs,
              backgroundColor: AppColors.white.withValues(alpha: 0.2),
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
    );
  }
}

typedef _CardData = ({IconData icon, String label, num value});
