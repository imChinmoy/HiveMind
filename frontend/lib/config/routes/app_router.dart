import 'package:frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:frontend/features/auth/presentation/screens/signup_screen.dart';
import 'package:frontend/features/home/presentation/screens/home_screen.dart';
import 'package:frontend/features/profile/presentation/screens/profile_screen.dart';
import 'package:frontend/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static bool isLoggedIn = false;

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,

    redirect: (context, state) {
      final loggedIn = isLoggedIn;
      final loggingIn =
          state.location == '/login' || state.location == '/signup';

      if (state.location == '/') return null;

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/home';

      return null;
    },

    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeShell()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/logout',
        redirect: (context, state) {
          isLoggedIn = false;
          return '/login';
        },
      ),
    ],
  );
}
