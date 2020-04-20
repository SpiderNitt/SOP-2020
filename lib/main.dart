

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


// Files importedimport 'dart:js';

import 'package:inductions_20/screens/mentee_home.dart';

void main() => runApp(
  DevicePreview(
    builder:(context) =>MyApp(),
    enabled: !kReleaseMode,
    )
);

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