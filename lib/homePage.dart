import 'package:flutter/material.dart';
import 'dart:ui';

import 'finance/loginScreen.dart';
import 'fitness/fitnessLogin.dart';
import 'luxury/ultraLuxuryAuthScreen.dart';
import 'socialMedia/socialMediaLoginScreen.dart';

class PremiumAuthShowcase extends StatefulWidget {
  @override
  _PremiumAuthShowcaseState createState() => _PremiumAuthShowcaseState();
}

class _PremiumAuthShowcaseState extends State<PremiumAuthShowcase>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentPage = 0;

  final List<AuthType> authTypes = [
    // AuthType('Luxury', const Color(0xFFD4AF37), Icons.diamond, LuxuryAuthScreen()),
    // AuthType('Fitness', const Color(0xFF4CAF50), Icons.fitness_center, FitnessAuthScreen()),
    // AuthType('Dining', const Color(0xFFFF5722), Icons.restaurant_menu, DiningAuthScreen()),
    // AuthType('Travel', const Color(0xFF03A9F4), Icons.flight, TravelAuthScreen()),
    // AuthType('Finance', const Color(0xFF9C27B0), Icons.account_balance, FinanceAuthScreen()),
    AuthType('Luxury', const Color(0xFFFFD700), Icons.diamond,
        UltraLuxuryAuthScreen()),
    AuthType('Fitness', const Color(0xFF00FF00), Icons.fitness_center,
        FitPulseLoginScreen()),
    // AuthType('Restaurant', const Color(0xFFFF4500), '🍽️', RestaurantAuthScreen()),
    AuthType('Finance', const Color(0xFF1E90FF), Icons.money,
        WealthWiseLoginScreen()),
    AuthType('Social Media', const Color(0xFF8A2BE2), Icons.tv,
        SocialMediaLoginScreen()),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToAuthScreen(BuildContext context, AuthType authType) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => authType.screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'Select Your Experience',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: authTypes.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }
                          return Center(
                            child: SizedBox(
                              height: Curves.easeOut.transform(value) * 400,
                              width: Curves.easeOut.transform(value) * 340,
                              child: child,
                            ),
                          );
                        },
                        child: PremiumAuthCard(
                          authType: authTypes[index],
                          onTap: () =>
                              _navigateToAuthScreen(context, authTypes[index]),
                        ),
                      );
                    },
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      'Swipe to explore more options',
                      style:
                          TextStyle(color: Colors.white60, letterSpacing: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: PremiumBackgroundPainter(
            animation: _animationController,
            color: authTypes[_currentPage].color.withOpacity(0.3),
          ),
          child: Container(),
        );
      },
    );
  }
}

class AuthType {
  final String name;
  final Color color;
  final IconData icon;
  final Widget screen;

  AuthType(this.name, this.color, this.icon, this.screen);
}

class PremiumAuthCard extends StatelessWidget {
  final AuthType authType;
  final VoidCallback onTap;

  const PremiumAuthCard({Key? key, required this.authType, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: authType.color.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: authType.color.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    authType.icon,
                    size: 80,
                    color: authType.color,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    authType.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: authType.color),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Enter',
                      style: TextStyle(
                        color: authType.color,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumBackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  PremiumBackgroundPainter({required this.animation, required this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final path = Path();

    for (int i = 0; i < 5; i++) {
      double progress = animation.value + i / 5;
      progress -= progress.floor();
      path.addPolygon([
        Offset(size.width * progress, 0),
        Offset(size.width * progress + size.width / 5, 0),
        Offset(size.width * progress + size.width / 10, size.height),
        Offset(size.width * progress - size.width / 10, size.height),
      ], true);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Finance Authentication'),
          backgroundColor: Colors.black),
      body: const Center(child: Text('Finance Authentication Screen')),
    );
  }
}
