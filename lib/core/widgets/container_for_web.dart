import 'package:donezo/core/widgets/container_width_inherited.dart';
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
        child: LayoutBuilder(builder: (context, constraints) {
          final containerWidth = constraints.maxWidth > 600 ? 430.0 : constraints.maxWidth;
          return ContainerWidthInherited(
            containerWidth: containerWidth,
            child: SizedBox(
              width: containerWidth,
              child: child,
            ),
          );
        }),
      ),
    );
  }
}
