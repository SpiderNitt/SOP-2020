import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

// Files imported
import 'package:inductions_20/screens/views/splash_screen.dart';
import 'package:inductions_20/screens/views/login/responsive_login_view.dart';
import 'package:inductions_20/screens/views/register.dart';

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
      home: Scaffold(
        backgroundColor: Color(0xFF00171f),
        body: RegisterView(),
      ),
    ),
  );
}
