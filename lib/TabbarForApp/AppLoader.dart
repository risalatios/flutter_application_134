import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Set the color to blue
      ),
    );
  }
}