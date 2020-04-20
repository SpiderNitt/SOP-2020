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
      '/': (context) => Home('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ'),
      '/menteetask' : (context) => MenteeTask(),
      '/writereview' : (context) => Review(),
      '/bio' : (context)=> Bio(),
      '/commits': (context)=> CommitsFinal(),
      '/review': (context) => Request() 
    },
  );
  }
}
