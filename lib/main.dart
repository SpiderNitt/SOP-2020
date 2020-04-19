import 'package:flutter/material.dart';
import 'package:inductions_20/review.dart';
import 'bio.dart';
import 'commitsfinal.dart';
import 'home.dart';
import 'write_widget.dart';
import 'mentee_task.dart';
import 'graphqltemp.dart';

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
      '/review': (context) => Graphqltemp(Request()) 
    },
  );
  }
}
