import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class FitPulseLoginScreen extends StatefulWidget {
  @override
  _FitPulseLoginScreenState createState() => _FitPulseLoginScreenState();
}

class _FitPulseLoginScreenState extends State<FitPulseLoginScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _logoAnimationController;
  int _stepCount = 0;
  List<String> _motivationalQuotes = [
    "The only bad workout is the one that didn't happen.",
    "Sweat is just your fat crying.",
    "Your body can stand almost anything. It's your mind that you have to convince.",
  ];
  int _currentQuoteIndex = 0;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/workout_video.mp4')
      ..initialize().then((_) {
        _videoController.play();
        _videoController.setLooping(true);
        setState(() {});
      });

    _logoAnimationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Change quote every 5 seconds
    Future.delayed(Duration(seconds: 5), _changeQuote);
  }

  void _changeQuote() {
    setState(() {
      _currentQuoteIndex =
          (_currentQuoteIndex + 1) % _motivationalQuotes.length;
    });
    Future.delayed(Duration(seconds: 5), _changeQuote);
  }

  @override
  void dispose() {
    _videoController.dispose();
    _logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Video
          _videoController.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                )
              : Container(color: Colors.black),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
          // Main Content
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 40),
                _buildLogo(),
                Spacer(),
                _buildLoginForm(),
                Spacer(),
                _buildMotivationalQuote(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _logoAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + 0.1 * _logoAnimationController.value,
          child: Text(
            'FitPulse',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildInputField(FontAwesomeIcons.user, 'Email'),
          SizedBox(height: 20),
          _buildInputField(FontAwesomeIcons.lock, 'Password', isPassword: true),
          SizedBox(height: 20),
          _buildLoginButton(),
          SizedBox(height: 20),
          _buildSocialLoginOptions(),
          SizedBox(height: 10),
          _buildStepCounter(),
        ],
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hint,
      {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      onChanged: (value) {
        setState(() {
          _stepCount += 1;
        });
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green),
        hintText: hint,
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2)),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement login logic
      },
      child: Text('Login', style: TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _buildSocialLoginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue),
            onPressed: () {}),
        IconButton(
            icon: Icon(FontAwesomeIcons.google, color: Colors.red),
            onPressed: () {}),
        IconButton(
            icon: Icon(FontAwesomeIcons.apple, color: Colors.black),
            onPressed: () {}),
      ],
    );
  }

  Widget _buildStepCounter() {
    return Text(
      'Steps: $_stepCount',
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMotivationalQuote() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Text(
        _motivationalQuotes[_currentQuoteIndex],
        key: ValueKey<int>(_currentQuoteIndex),
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
    );
  }
}
