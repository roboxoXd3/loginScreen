import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:math' as math;

class LuxuryAuthScreen extends StatefulWidget {
  @override
  _LuxuryAuthScreenState createState() => _LuxuryAuthScreenState();
}

class _LuxuryAuthScreenState extends State<LuxuryAuthScreen> with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _formController;
  late AnimationController _logoController;
  late AnimationController _inputFieldController;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(duration: const Duration(seconds: 10), vsync: this)..repeat();
    _formController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _logoController = AnimationController(duration: const Duration(seconds: 5), vsync: this)..repeat();
    _inputFieldController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _buttonController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _formController.forward();
    _inputFieldController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _formController.dispose();
    _logoController.dispose();
    _inputFieldController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(controller: _backgroundController),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: AnimatedBuilder(
                  animation: _formController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: Curves.elasticOut.transform(_formController.value),
                      child: Opacity(
                        opacity: _formController.value,
                        child: Container(
                          margin: const EdgeInsets.all(24),
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedLogo(controller: _logoController),
                              const SizedBox(height: 24),
                              const ShimmeringText(
                                text: 'Welcome Back',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 32),
                              AnimatedInputField(
                                controller: _inputFieldController,
                                delay: 0,
                                hintText: 'Username',
                                icon: Icons.person_outline,
                              ),
                              const SizedBox(height: 16),
                              AnimatedInputField(
                                controller: _inputFieldController,
                                delay: 0.2,
                                hintText: 'Password',
                                icon: Icons.lock_outline,
                                isPassword: true,
                              ),
                              const SizedBox(height: 32),
                              PulsatingButton(
                                controller: _buttonController,
                                text: 'Sign In',
                                onPressed: () {
                                  // Handle sign in
                                },
                              ),
                              const SizedBox(height: 24),
                              const FadingText(
                                text: "Don't have an account? Sign up",
                                delay: 0.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
          child: Image.asset(
            'assets/logo.png',
            height: 80,
            width: 80,
            color: Colors.amber[400],
          ),
        );
      },
    );
  }
}

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
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[400]),
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

class PulsatingButton extends StatelessWidget {
  final AnimationController controller;
  final String text;
  final VoidCallback onPressed;

  const PulsatingButton({
    Key? key,
    required this.controller,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + 0.1 * math.sin(controller.value * 2 * math.pi),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber[400]!, Colors.orange[500]!],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber[400]!.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                controller.forward(from: 0);
                onPressed();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FadingText extends StatelessWidget {
  final String text;
  final double delay;

  const FadingText({Key? key, required this.text, required this.delay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Interval(delay, 1.0, curve: Curves.easeOut),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
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