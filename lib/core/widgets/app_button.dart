// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../config/theme/app_color.dart';

class AppButton extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;
  final double? width;
  const AppButton({
    super.key,
    required this.child,
    this.onTap,
    this.width,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    const double shadowHeight = 3;
    double position = 4;
    const double buttonHeight = 54 - shadowHeight;
    final double width = widget.width != null ? widget.width! - 24 : MediaQuery.of(context).size.width - 24;
    return _buildButton(
      position,
      buttonHeight,
      shadowHeight,
      width,
      widget.child,
      widget.onTap,
    );
  }
}

StatefulBuilder _buildButton(double position, double buttonHeight, double shadowHeight, double? width, Widget child, void Function()? onTap) {
  return StatefulBuilder(builder: (context, setState) {
    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          position = 4;
        });
      },
      onTapDown: (_) {
        setState(() {
          position = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          position = 4;
        });
      },
      onTap: onTap,
      child: SizedBox(
        height: buttonHeight + shadowHeight,
        width: width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: buttonHeight,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            AnimatedPositioned(
                bottom: position,
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 40),
                child: Container(
                  width: width,
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.3,
                    ),
                  ),
                  child: Center(
                    child: child,
                  ),
                ))
          ],
        ),
      ),
    );
  });
}
