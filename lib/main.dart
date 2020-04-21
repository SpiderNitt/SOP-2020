import 'package:flutter/material.dart';

// Files imported
import 'package:inductions_20/screens/splash_screen.dart';
import 'package:inductions_20/screens/login.dart';
import 'package:inductions_20/screens/mentor_navigation.dart';
import 'package:inductions_20/screens/mentee_navigation.dart';
import 'package:inductions_20/screens/github_username.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Spider Orientation',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/github_username': (context) => GetGithubUsernameView(),
      },
    ),
  );
}
