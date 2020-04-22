import 'package:flutter/material.dart';
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
      '/': (context) => Home('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc2NDUzODQsImZ1bGxuYW1lIjoiIiwiZ2l0aHViX3VzZXJuYW1lIjoiYW5pc2giLCJpc19tZW50b3IiOnRydWUsInJvbGwiOiIxMDcxMTgwMTUiLCJ1c2VybmFtZSI6ImFuaXNoIn0.lNAUYuv3prlzvqgiQpoOofYB7OOG8Kku3DL83qIKThQ'),
      '/menteetask' : (context) => MenteeTask(),
      '/writereview' : (context) => Review(),
      '/bio' : (context)=> Bio(),
      '/commits': (context)=> CommitsFinal(),
      '/review': (context) => Request() 
    },
  );
  }
}
