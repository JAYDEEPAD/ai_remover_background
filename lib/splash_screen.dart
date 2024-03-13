import 'package:flutter/material.dart';

import 'onnbord.dart';
// void main(){
//   runApp(MaterialApp
//     (
//       debugShowCheckedModeBanner: false,home: SplashScreen()));
// }
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
  }

  _navigateToMainScreen() async {
    await Future.delayed(Duration(seconds: 6),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple[100]!,
                Colors.deepPurple[200]!,
                Colors.deepPurple[300]!,
                Colors.deepPurple[400]!,
                Colors.deepPurple[500]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/image/img_13.png'), height: 60, width: 60),
                SizedBox(height: 20.0),
                Text(
                  'Photo Me',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}


