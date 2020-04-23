import 'package:flutter/material.dart';

// Files imported
import 'package:inductions_20/screens/splash_screen.dart';
import 'package:inductions_20/screens/login.dart';
import 'package:inductions_20/screens/mentor_navigation.dart';
import 'package:inductions_20/screens/mentee_navigation.dart';
import 'package:inductions_20/screens/get_details.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Spider Orientation',
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/get_details': (context) => GetDetails(),
      },
    ),
  );
}
