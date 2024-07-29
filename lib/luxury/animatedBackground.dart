import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;

  const AnimatedBackground({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                HSLColor.fromAHSL(1, controller.value * 360, 0.8, 0.2).toColor(),
                HSLColor.fromAHSL(1, (controller.value * 360 + 60) % 360, 0.8, 0.2).toColor(),
                HSLColor.fromAHSL(1, (controller.value * 360 + 120) % 360, 0.8, 0.2).toColor(),
              ],
            ),
          ),
        );
      },
    );
  }
}