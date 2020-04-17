import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

// Files imported
import 'package:inductions_20/screens/views/splash_screen.dart';
import 'package:inductions_20/screens/views/login/responsive_login_view.dart';
import 'package:inductions_20/screens/views/register.dart';
import 'package:inductions_20/screens/views/success_message.dart';

void main() {
  runApp(
//    DevicePreview(
//      builder: (context) => MaterialApp(
//        home: Scaffold(
//          backgroundColor: Color(0xFF00171f),
//          body: LoginView(),
//        ),
//      ),
//    ),
    MaterialApp(
      title: 'Spider Orientation',
      home: Scaffold(
        body: Container(
          child: LoginView(),
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
