import 'package:flutter/material.dart';

class AnimatedInputField extends StatelessWidget {
  final AnimationController controller;
  final double delay;
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const AnimatedInputField({
    Key? key,
    required this.controller,
    required this.delay,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final Animation<double> animation = CurvedAnimation(
          parent: controller,
          curve: Interval(delay, 1.0, curve: Curves.elasticOut),
        );
        return Transform.translate(
          offset: Offset(0, 50 * (1 - animation.value)),
          child: Opacity(
            opacity: animation.value,
            child: TextField(
              obscureText: isPassword,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(icon, color: Colors.amber[400]),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.amber[400]!, width: 2),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}