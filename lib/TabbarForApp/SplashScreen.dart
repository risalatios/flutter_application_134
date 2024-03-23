import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_134/TabbarForApp/LoginPhoneScreen.dart';
import 'LoginScreen.dart'; 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to the next screen
    Timer(Duration(seconds: 3), () {
     Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
     );
    });
  }

  @override
   Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/splashback.png'), // Replace 'assets/splash_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
      );
  }
}
