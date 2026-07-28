import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:miabe_quiz/core/routing/app_routes.dart";
import "package:miabe_quiz/presentation/pages/box_page.dart";
import "package:miabe_quiz/presentation/pages/index.dart";
import "package:miabe_quiz/presentation/pages/profile_page.dart";
import "package:miabe_quiz/presentation/pages/quiz_page.dart";
import "package:miabe_quiz/presentation/pages/subject_detail_page.dart";

final appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    // App shell with bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) {
                final username = state.uri.queryParameters["name"] ?? "Abalo";
                return HomePage(username: username);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.subjects,
              builder: (context, state) => const SubjectPage(),
              routes: [
                GoRoute(
                  path: ":id",
                  builder: (_, state) {
                    final id = state.pathParameters["id"] ?? "";
                    return SubjectDetailPage(subjectId: id);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.quizzes,
              builder: (context, state) =>
                  const QuizPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.boxes,
              builder: (context, state) =>
                  const BoxPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) =>
              const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
