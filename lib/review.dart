import 'package:flutter/material.dart';
import 'package:inductions_20/requestreviewdis.dart';
import 'config.dart';
import 'navigationbar.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override

 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Review Requests'),
        centerTitle: true,
        backgroundColor: config.bgColor,
      ),
      body: Requestlist('anish', 'chakki1234'),
      bottomNavigationBar: NavigationBar(1),
    );
  }
}