import "package:go_router/go_router.dart";
import "package:miabe_quiz/core/routing/app_routes.dart";
import "package:miabe_quiz/presentation/pages/index.dart";

final appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
  ],
);
