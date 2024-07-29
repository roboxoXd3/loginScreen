import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'animatedLinkText.dart';
import 'luxuryAuthScreen.dart';
import 'neonButton.dart';

class AuthForm extends StatelessWidget {
  final AnimationController logoController;
  final AnimationController formController;

  const AuthForm({
    Key? key,
    required this.logoController,
    required this.formController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedLogo(controller: logoController),
        const SizedBox(height: 24),
        const ShimmeringText(
          text: 'Welcome Back',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 32),
        AnimatedInputField(
          controller: formController,
          delay: 0.2,
          hintText: 'Username',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        AnimatedInputField(
          controller: formController,
          delay: 0.4,
          hintText: 'Password',
          icon: Icons.lock_outline,
          isPassword: true,
        ),
        const SizedBox(height: 32),
        NeonButton(
          text: 'Sign In',
          onPressed: () {
            // Handle sign in
          },
        ),
        const SizedBox(height: 24),
        const AnimatedLinkText(
          text: "Don't have an account? Sign up",
          delay: 0.6,
        ),
      ],
    );
  }
}