import 'package:flutter/material.dart';
import 'dart:math' as math;

class SocialMediaLoginScreen extends StatefulWidget {
  @override
  _SocialMediaLoginScreenState createState() => _SocialMediaLoginScreenState();
}

class _SocialMediaLoginScreenState extends State<SocialMediaLoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _activeUsers = 1000;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    Future.delayed(Duration(seconds: 1), _incrementActiveUsers);
  }

  void _incrementActiveUsers() {
    setState(() {
      _activeUsers += math.Random().nextInt(10);
    });
    Future.delayed(Duration(milliseconds: 500), _incrementActiveUsers);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnhancedBackground(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40),
              _buildLogo(),
              Spacer(),
              _buildLoginForm(),
              SizedBox(height: 20),
              _buildActiveUsersCounter(),
              Spacer(),
              _buildLanguageSelector(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 2),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: Text(
              'ConnectSphere',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginForm() {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInputField(Icons.person, 'Username'),
          SizedBox(height: 20),
          _buildInputField(Icons.lock, 'Password', isPassword: true),
          SizedBox(height: 20),
          _buildLoginButton(),
          SizedBox(height: 20),
          _buildSocialLoginOptions(),
        ],
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hint,
      {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.purple),
        hintText: hint,
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 2)),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Implement login logic
        },
        child: Text('Login', style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.purple,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildSocialLoginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialIcon(Icons.facebook, Colors.blue),
        _buildSocialIcon(Icons.android, Colors.green),
        _buildSocialIcon(Icons.apple, Colors.black),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return CircleAvatar(
      backgroundColor: color,
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildActiveUsersCounter() {
    return Text(
      '$_activeUsers people connecting right now',
      style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 16),
    );
  }

  Widget _buildLanguageSelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: Icon(Icons.language, color: Colors.white),
          onPressed: () {
            // Implement language selection
          },
        ),
      ),
    );
  }
}

class EnhancedBackground extends StatefulWidget {
  final Widget child;

  EnhancedBackground({required this.child});

  @override
  _EnhancedBackgroundState createState() => _EnhancedBackgroundState();
}

class _EnhancedBackgroundState extends State<EnhancedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: BubblePainter(_controller.value),
              child: Container(),
            );
          },
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: EmojiPainter(_controller.value),
              child: Container(),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class BubblePainter extends CustomPainter {
  final double animation;

  BubblePainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.purple.withOpacity(0.2), Colors.pink.withOpacity(0.2)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final numBubbles = 30;
    final random = math.Random(42);

    for (int i = 0; i < numBubbles; i++) {
      final x = random.nextDouble() * size.width;
      final baseY = random.nextDouble() * size.height;
      final y = (baseY - animation * size.height) % size.height;
      final radius = random.nextDouble() * 30 + 5;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class EmojiPainter extends CustomPainter {
  final double animation;
  final List<String> emojis = ['😀', '❤️', '👍', '🎉', '🌟'];

  EmojiPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final numEmojis = 5;

    for (int i = 0; i < numEmojis; i++) {
      final x = random.nextDouble() * size.width;
      final baseY = random.nextDouble() * size.height;
      final y = size.height - (baseY + animation * size.height) % size.height;

      final textPainter = TextPainter(
        text: TextSpan(
          text: emojis[random.nextInt(emojis.length)],
          style: TextStyle(fontSize: 24),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
