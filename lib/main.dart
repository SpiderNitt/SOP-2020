import 'package:flutter/material.dart';
import 'package:inductions_20/review.dart';
import 'bio.dart';
import 'commitsfinal.dart';
import 'home.dart';
import 'write_widget.dart';
import 'mentee_task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    routes: {
      '/': (context) => Home('Anish', 'chakki1234'),
      '/menteetask' : (context) => MenteeTask(),
      '/writereview' : (context) => Review(),
      '/bio' : (context)=> Bio(),
      '/commits': (context)=> CommitsFinal(),
      '/review': (context) => Request() 
    },
  );
  }
}
