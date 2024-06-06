import 'package:flutter/material.dart';
import 'package:donezo/core/routes/navigation_menu.dart';
import 'package:donezo/core/theme/app_theme.dart';

void main() {
  runApp(const Donezo());
}

class Donezo extends StatelessWidget {
  const Donezo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Donezo',
      home: const NavigationMenu(),
    );
  }
}
