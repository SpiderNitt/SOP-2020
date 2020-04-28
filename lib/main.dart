// Files imported
import 'package:inductions_20/screens/mentee/mentee_announcement.dart';
import 'package:inductions_20/screens/mentor/Taskdetails.dart';
import 'package:inductions_20/screens/mentor/bio.dart';
import 'package:inductions_20/screens/mentor/commitsfinal.dart';
import 'package:inductions_20/screens/mentor/mentee_task.dart';
import 'package:inductions_20/screens/mentor/mentor_announcement.dart';
import 'package:inductions_20/screens/mentor/review.dart';
import 'package:inductions_20/screens/mentor/write_widget.dart';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/navigation/login.dart';
import 'package:inductions_20/screens/navigation/splash_screen.dart';
import 'package:inductions_20/screens/mentee/biomentee.dart';

import 'package:inductions_20/screens/mentee/mentee_home.dart';

void main() => runApp(Spider());

class Spider extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spider Orientation',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        // '/get_details': (context) => GetDetails(),
        '/menteetask': (context) => MenteeTask(),
        '/writereview': (context) => Review(),
        '/bio': (context) => Bio(),
        '/commits': (context) => CommitsFinal(),
        '/review': (context) => Request(),
        '/task': (context) => Tasklist(),
        '/mentee/': (context) => HomePage(),
        '/mentee/announcement': (context) => MenteeAnnouncement(),
        '/mentor/announcement': (context) => MentorAnnouncement(),
        '/biomentee': (context) => Biomentee(),
      },
    );
  }
}
