import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget, Widget, runApp;

// Files imported
import 'package:inductions_20/screens/splash_screen.dart';
import 'package:inductions_20/screens/login.dart';
import 'package:inductions_20/screens/get_details.dart';

void main() {
  runApp(Spider());
}

class Spider extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spider Orientation',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/get_details': (context) => GetDetails(),
      },
    );
  }
}
