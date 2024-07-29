import 'package:flutter/material.dart';

import 'authForm.dart';
import 'floatingElements.dart';
import 'glassmorphicContainer.dart';
import 'luxuryAuthScreen.dart';
import 'particlepainter.dart';

class UltraLuxuryAuthScreen extends StatefulWidget {
  @override
  _UltraLuxuryAuthScreenState createState() => _UltraLuxuryAuthScreenState();
}

class _UltraLuxuryAuthScreenState extends State<UltraLuxuryAuthScreen> with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _formController;
  late AnimationController _logoController;
  late AnimationController _particleController;
  late AnimationController _floatingElementsController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(duration: Duration(seconds: 10), vsync: this)..repeat();
    _formController = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    _logoController = AnimationController(duration: Duration(seconds: 5), vsync: this)..repeat();
    _particleController = AnimationController(duration: Duration(seconds: 4), vsync: this)..repeat();
    _floatingElementsController = AnimationController(duration: Duration(seconds: 6), vsync: this)..repeat();

    _formController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _formController.dispose();
    _logoController.dispose();
    _particleController.dispose();
    _floatingElementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(controller: _backgroundController),
          ParticleOverlay(controller: _particleController),
          FloatingElements(controller: _floatingElementsController),
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
                        child: GlassomorphicContainer(
                          child: AuthForm(
                            logoController: _logoController,
                            formController: _formController,
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