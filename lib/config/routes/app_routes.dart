import 'package:donezo/config/routes/navigation_menu.dart';
import 'package:donezo/core/di/injection_container.dart';
import 'package:donezo/src/auth/presentation/pages/sign_in_page.dart';
import 'package:donezo/src/auth/presentation/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String notFound = '/not-found';

  static final routes = GoRouter(
    initialLocation: sl<FirebaseAuth>().currentUser != null ? home : signIn,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) {
          final user = sl<FirebaseAuth>().currentUser;
          if (user == null) {
            return const SignInPage();
          } else {
            return const NavigationMenu();
          }
        },
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: signIn,
        builder: (context, state) => const SignInPage(),
      ),
    ],
  );
}
