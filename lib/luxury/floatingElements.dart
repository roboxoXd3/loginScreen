import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingElements extends StatelessWidget {
  final AnimationController controller;

  const FloatingElements({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: List.generate(10, (index) {
            final random = math.Random(index);
            final size = 20.0 + random.nextDouble() * 30;
            final x = random.nextDouble() * MediaQuery.of(context).size.width;
            final y = random.nextDouble() * MediaQuery.of(context).size.height;
            final offset = Offset(
              x + 20 * math.sin(controller.value * 2 * math.pi + index),
              y + 20 * math.cos(controller.value * 2 * math.pi + index),
            );

            return Positioned(
              left: offset.dx,
              top: offset.dy,
              child: Opacity(
                opacity: 0.3 + 0.2 * math.sin(controller.value * 2 * math.pi + index),
                child: Icon(
                  Icons.star,
                  size: size,
                  color: Colors.amber[400],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}