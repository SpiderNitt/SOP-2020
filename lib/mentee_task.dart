import 'package:flutter/material.dart';
import 'mentor_details.dart';
import 'navigationbar.dart';
import 'repodet.dart';
import 'config.dart';

class MenteeTask extends StatefulWidget {
  @override
  _MenteeTaskState createState() => _MenteeTaskState();
}

class _MenteeTaskState extends State<MenteeTask> {
  @override

  Widget build(BuildContext context) {
   Map data = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: config.bgColor,
        title: Text('Mentee task'),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Column(
        children: <Widget>[
        MenDet(data['name'], data['git']),
        SizedBox(height: 10),
        Text('Repositories',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.bordColor)),
        SizedBox(height: 10),
        RepoDet(data['git'], data['name']),
       ]
      ),
      ),
      bottomNavigationBar: NavigationBar(0),
    );
  }
}
