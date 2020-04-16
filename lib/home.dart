import 'package:flutter/material.dart';
import 'config.dart';
import 'mentees_details.dart';
import 'navigationbar.dart';
import 'mentor_details.dart';

class Home extends StatefulWidget {

String name;
String gitacc;
 
  Home(String name, String gitacc){
    this.name = name;
    this.gitacc = gitacc;
  }

  @override
  _HomeState createState() => _HomeState(this.name, this.gitacc);
}

class _HomeState extends State<Home> {

String name;
String gitacc;
 
  _HomeState(String name, String gitacc){
    this.name = name;
    this.gitacc = gitacc;
  }
 
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Mentor Page'),
        centerTitle: true,
        backgroundColor: config.bgColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child : Column(
      children: <Widget>[
        MenDet(this.name, this.gitacc),
        SizedBox(height: 10),
        Text('Mentee details',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        SizedBox(height: 10),
        MenteeDet(this.name, this.gitacc)
      ],
      ),
        ),
        ),
      bottomNavigationBar: NavigationBar(0),
    );
  }
}


