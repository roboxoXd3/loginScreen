import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParticleOverlay extends StatelessWidget {
  final AnimationController controller;

  const ParticleOverlay({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(animation: controller),
          child: Container(),
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final Animation<double> animation;

  ParticlePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.6);
    final random = math.Random(42);

    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final offset = Offset(x, y);
      final radius = 1 + random.nextDouble() * 2;

      canvas.drawCircle(
        offset,
        radius * (0.5 + 0.5 * math.sin(animation.value * 2 * math.pi + i)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}