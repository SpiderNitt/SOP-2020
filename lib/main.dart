import 'package:flutter/material.dart';
import './screens/Taskdetails.dart';
import './screens/review.dart';
import './screens/bio.dart';
import './screens/commitsfinal.dart';
import './screens/home.dart';
import './screens/write_widget.dart';
import './screens/mentee_task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    routes: {
      '/': (context) => Home('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc3Mzg4OTYsImZ1bGxuYW1lIjoiQW5pc2ggYyIsImdpdGh1Yl91c2VybmFtZSI6ImNoYWtraTEyMzQiLCJpc19tZW50b3IiOnRydWUsInJvbGwiOiIxMDcxMTgwMTUiLCJ1c2VybmFtZSI6IkFuaXNoIGMifQ.iwKXqDSFkP9vY6WX7s5h4gv6I1JNafPLn3CbkzNThd8'),
      '/menteetask' : (context) => MenteeTask(),
      '/writereview' : (context) => Review(),
      '/bio' : (context)=> Bio(),
      '/commits': (context)=> CommitsFinal(),
      '/review': (context) => Request(),
      '/task': (context) => Tasklist()
    },
  );
  }
}
