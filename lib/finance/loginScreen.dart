import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WealthWiseLoginScreen extends StatefulWidget {
  @override
  _WealthWiseLoginScreenState createState() => _WealthWiseLoginScreenState();
}

class _WealthWiseLoginScreenState extends State<WealthWiseLoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackgroundChart(controller: _controller),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 60),
                AnimatedLogo(),
                Spacer(),
                FrostedGlassContainer(
                  child: LoginForm(),
                ),
                Spacer(),
                CurrencyTicker(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedBackgroundChart extends StatelessWidget {
  final AnimationController controller;

  AnimatedBackgroundChart({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0A2342).withOpacity(0.9),
                Color(0xFF0A2342).withOpacity(0.6),
              ],
            ),
          ),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 10,
              minY: 0,
              maxY: 6,
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 3 + sin(controller.value * 2 * 3.14) * 0.5),
                    FlSpot(2.5, 2 + cos(controller.value * 2 * 3.14) * 0.5),
                    FlSpot(5, 5 - sin(controller.value * 2 * 3.14) * 0.5),
                    FlSpot(7.5, 3.5 + cos(controller.value * 2 * 3.14) * 0.5),
                    FlSpot(10, 4 + sin(controller.value * 2 * 3.14) * 0.5),
                  ],
                  isCurved: true,
                  color: Color(0xFFFFD700),
                  barWidth: 3,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                      show: true, color: Color(0xFFFFD700).withOpacity(0.1)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 2),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: Text(
              'WealthWise',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FrostedGlassContainer extends StatelessWidget {
  final Widget child;

  FrostedGlassContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(icon: FontAwesomeIcons.user, hintText: 'Username'),
        SizedBox(height: 20),
        CustomTextField(
            icon: FontAwesomeIcons.lock,
            hintText: 'Password',
            isPassword: true),
        SizedBox(height: 20),
        BiometricLoginButton(),
        SizedBox(height: 20),
        LoginButton(),
        SizedBox(height: 10),
        SecurityBadge(),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;

  CustomTextField(
      {required this.icon, required this.hintText, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFFFFD700)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFFD700)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
        ),
      ),
    );
  }
}

class BiometricLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Implement biometric login logic here
      },
      icon: Icon(FontAwesomeIcons.fingerprint, color: Color(0xFF0A2342)),
      label: Text('Login with Touch ID',
          style: TextStyle(color: Color(0xFF0A2342))),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFD700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement login logic here
      },
      child: Text('Log In', style: TextStyle(color: Color(0xFF0A2342))),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFD700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
      ),
    );
  }
}

class SecurityBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.lock, color: Color(0xFFFFD700), size: 16),
        SizedBox(width: 8),
        Text('Secure Login', style: TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class CurrencyTicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          TickerItem('USD/EUR', '0.84'),
          TickerItem('GBP/USD', '1.39'),
          TickerItem('USD/JPY', '109.64'),
          TickerItem('USD/CAD', '1.21'),
        ],
      ),
    );
  }
}

class TickerItem extends StatelessWidget {
  final String pair;
  final String rate;

  TickerItem(this.pair, this.rate);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFFFFD700), width: 1)),
      ),
      child: Text(
        '$pair: $rate',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
