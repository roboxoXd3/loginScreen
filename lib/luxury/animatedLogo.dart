import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedLogo extends StatelessWidget {
  final AnimationController controller;

  const AnimatedLogo({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateY(controller.value * 2 * math.pi)
            ..scale(1 + 0.1 * math.sin(controller.value * 2 * math.pi)),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.amber, Colors.deepOrange],
              stops: [controller.value, controller.value + 0.5],
            ).createShader(bounds),
            child: Image.asset(
              'assets/logo.png',
              height: 80,
              width: 80,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}