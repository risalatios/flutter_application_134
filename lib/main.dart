import 'package:flutter/material.dart';
import 'package:flutter_application_134/TabbarForApp/HomeScreen.dart';
import 'package:flutter_application_134/TabbarForApp/TabbarViewCustom.dart';
import 'TabbarForApp/SplashScreen.dart';
void main() {
  runApp(EntryPointOfApp());
}

class EntryPointOfApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}


