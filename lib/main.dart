import 'package:flutter/material.dart';

// Files imported
import 'package:inductions_20/screens/login.dart';
import 'package:inductions_20/screens/register.dart';
import 'package:inductions_20/screens/success_message.dart';
import 'package:inductions_20/screens/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Spider Orientation',
      home: Scaffold(
        body: Container(
          child: Message(),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                Color(0xFF003459),
                Color(0xFF00171f),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
