// Files imported
import 'package:inductions_20/screens/splash_screen.dart';
import 'package:inductions_20/screens/login.dart';
import 'package:inductions_20/screens/get_details.dart';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/Taskdetails.dart';
import 'package:inductions_20/screens/review.dart';
import 'package:inductions_20/screens/bio.dart';
import 'package:inductions_20/screens/commitsfinal.dart';
import 'package:inductions_20/screens/write_widget.dart';
import 'package:inductions_20/screens/mentee_task.dart';

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
        '/menteetask': (context) => MenteeTask(),
        '/writereview': (context) => Review(),
        '/bio': (context) => Bio(),
        '/commits': (context) => CommitsFinal(),
        '/review': (context) => Request(),
        '/task': (context) => Tasklist()
      },
    );
  }
}
