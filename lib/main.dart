import 'package:donezo/core/bloc/provider.dart';
import 'package:donezo/core/di/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:donezo/config/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/app_routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Donezo());
}

class Donezo extends StatelessWidget {
  const Donezo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp.router(
        routerConfig: AppRoutes.routes,
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Donezo',
      ),
    );
  }
}
