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

 String jwt;

 Widget build(BuildContext context) {

   Map data = ModalRoute.of(context).settings.arguments;
   this.jwt = data['jwt'];

    return Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
         automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Review Requests'),
        centerTitle: true,
        backgroundColor: config.bgColor,
      ),
      body: SingleChildScrollView(
        child: Requestlist('anish', 'chakki1234', this.jwt),
      ),
      bottomNavigationBar: NavigationBar(1, this.jwt),
    );
  }
}