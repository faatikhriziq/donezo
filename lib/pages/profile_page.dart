import 'package:donezo/config/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/di/injection_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          final firebaseAuth = sl<FirebaseAuth>();
          await firebaseAuth.signOut();
          if (!context.mounted) return;
          context.go(AppRoutes.signIn);
        },
        child: const Text('Sign Out'),
      )),
    );
  }
}
