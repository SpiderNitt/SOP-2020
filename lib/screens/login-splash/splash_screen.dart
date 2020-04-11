import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // todo: implement initState
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      _navigateToLogin();
    });
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[
                  Color(0xFF003459),
                  Color(0xFF00171f),
                ],
              ),
            ),
            child: Center(
              child: Image(
                image: AssetImage(
                  'assets/images/spiderIcon.webp',
                ),
                height: 200,
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
