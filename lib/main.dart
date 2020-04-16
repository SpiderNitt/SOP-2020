import 'package:flutter/material.dart';


// Files imported

import 'package:inductions_20/screens/mentee_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      debugShowCheckedModeBanner: false,
      home: homepage()
       );
  }
}