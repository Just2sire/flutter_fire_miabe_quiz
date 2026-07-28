import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:miabe_quiz/core/routing/app_routes.dart";
import "package:miabe_quiz/presentation/pages/index.dart";
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
                final username = state.uri.queryParameters["name"] ?? "Unknow";
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
                  const Scaffold(body: Center(child: Text("Quiz"))),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text("Profil"))),
            ),
          ],
        ),
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: AppRoutes.profile,
        //       pageBuilder: (context, state) => AppTransitions.fadeSlide(
        //         context: context,
        //         state: state,
        //         child: const Scaffold(body: Center(child: Text("Profile"))),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    ),
  ],
);
