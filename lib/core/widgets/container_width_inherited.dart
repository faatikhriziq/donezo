import 'package:flutter/material.dart';

class ContainerWidthInherited extends InheritedWidget {
  final double containerWidth;

  const ContainerWidthInherited({
    super.key,
    required this.containerWidth,
    required super.child,
  });

  static ContainerWidthInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContainerWidthInherited>()!;
  }

  @override
  bool updateShouldNotify(ContainerWidthInherited oldWidget) {
    return containerWidth != oldWidget.containerWidth;
  }
}
