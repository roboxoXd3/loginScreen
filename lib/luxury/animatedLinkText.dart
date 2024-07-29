import 'package:flutter/material.dart';

class AnimatedLinkText extends StatelessWidget {
  final String text;
  final double delay;

  const AnimatedLinkText({Key? key, required this.text, required this.delay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500),
      curve: Interval(delay, 1.0, curve: Curves.easeOut),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(color: Colors.grey[300]),
          children: [
            TextSpan(
              text: 'Sign up',
              style: TextStyle(
                color: Colors.amber[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}