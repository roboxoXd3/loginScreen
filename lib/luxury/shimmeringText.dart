import 'package:flutter/material.dart';

class ShimmeringText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ShimmeringText({Key? key, required this.text, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Colors.amber, Colors.white],
        stops: [0.0, 0.5, 1.0],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}