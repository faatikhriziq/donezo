import 'package:flutter/material.dart';

class ContainerForWeb extends StatelessWidget {
  final Widget child;
  const ContainerForWeb({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF636363),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: MediaQuery.of(context).size.width > 600 ? 450 : MediaQuery.of(context).size.width,
            child: child,
          ),
        ),
      ),
    );
  }
}
