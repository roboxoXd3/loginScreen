// import 'package:flutter/material.dart';
// import 'finance/loginScreen.dart';
// import 'fitness/fitnessLogin.dart';
// import 'luxury/luxuryAuthScreen.dart';
// import 'luxury/ultraLuxuryAuthScreen.dart';
// import 'socialMedia/socialMediaLoginScreen.dart';

// class LoginListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login UI Showcase'),
//       ),
//       body: ListView(
//         children: [
//           _buildLoginTile(context, 'Finance Login', WealthWiseLoginScreen()),
//           _buildLoginTile(context, 'Fitness Login', FitPulseLoginScreen()),
//           _buildLoginTile(context, 'Luxury Auth', LuxuryAuthScreen()),
//           _buildLoginTile(
//               context, 'Ultra Luxury Auth', UltraLuxuryAuthScreen()),
//           _buildLoginTile(
//               context, 'Social Media Login', SocialMediaLoginScreen()),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginTile(BuildContext context, String title, Widget screen) {
//     return ListTile(
//       title: Text(title),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => screen),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'finance/loginScreen.dart';
import 'fitness/fitnessLogin.dart';
import 'luxury/luxuryAuthScreen.dart';
import 'luxury/ultraLuxuryAuthScreen.dart';
import 'socialMedia/socialMediaLoginScreen.dart';

class LoginListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[900]!, Colors.blue[600]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: AnimationLimiter(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        _buildLoginCard(context, 'Finance Login',
                            WealthWiseLoginScreen(), Icons.account_balance),
                        _buildLoginCard(context, 'Fitness Login',
                            FitPulseLoginScreen(), Icons.fitness_center),
                        _buildLoginCard(context, 'Luxury Auth',
                            LuxuryAuthScreen(), Icons.star),
                        _buildLoginCard(context, 'Ultra Luxury Auth',
                            UltraLuxuryAuthScreen(), Icons.diamond),
                        _buildLoginCard(context, 'Social Media Login',
                            SocialMediaLoginScreen(), Icons.people),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[800]!, Colors.blue[600]!],
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.lock, color: Colors.white, size: 30),
          SizedBox(width: 16),
          Text(
            'Login UI Showcase',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(
      BuildContext context, String title, Widget screen, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, size: 40, color: Colors.blue[700]),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text('Tap to view this login screen',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.blue[700]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
