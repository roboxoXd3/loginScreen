import 'package:flutter/material.dart';

class NeonButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const NeonButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  _NeonButtonState createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this)..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 2.0, end: 5.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.amber[400]!.withOpacity(0.6),
                blurRadius: _glowAnimation.value,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[400],
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}