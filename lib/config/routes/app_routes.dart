import 'package:donezo/config/routes/navigation_menu.dart';
import 'package:donezo/core/di/injection_container.dart';
import 'package:donezo/core/widgets/container_for_web.dart';
import 'package:donezo/src/auth/presentation/pages/sign_in_page.dart';
import 'package:donezo/src/auth/presentation/pages/sign_up_page.dart';
import 'package:donezo/src/task_management/presentation/pages/task_form_page.dart';
import 'package:donezo/src/task_management/presentation/pages/task_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String task = '/task';
  static const String taskForm = '/task-form';

  static const String notFound = '/not-found';

  static final routes = GoRouter(
    initialLocation: sl<FirebaseAuth>().currentUser != null ? home : signIn,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) {
          final user = sl<FirebaseAuth>().currentUser;
          if (user == null) {
            return kIsWeb ? const ContainerForWeb(child: SignInPage()) : const SignInPage();
          } else {
            return kIsWeb ? const ContainerForWeb(child: NavigationMenu()) : const NavigationMenu();
          }
        },
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => kIsWeb ? const ContainerForWeb(child: SignUpPage()) : const SignUpPage(),
      ),
      GoRoute(
        path: signIn,
        builder: (context, state) => kIsWeb ? const ContainerForWeb(child: SignInPage()) : const SignInPage(),
      ),
      GoRoute(
        path: taskForm,
        builder: (context, state) => kIsWeb ? const ContainerForWeb(child: TaskFormPage()) : const TaskFormPage(),
      ),
    ],
  );
}
