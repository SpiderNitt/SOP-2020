import 'package:flutter/material.dart';
import 'package:inductions_20/graphqltemp.dart';
import 'package:inductions_20/stats.dart';
import 'mentor_details.dart';
import 'navigationbar.dart';
import 'repodet.dart';
import 'config.dart';
import 'jwtparse.dart';

class MenteeTask extends StatefulWidget {
  @override
  _MenteeTaskState createState() => _MenteeTaskState();
}

class _MenteeTaskState extends State<MenteeTask> {
  
  dynamic res;
  String jwt;
  
  @override
  Widget build(BuildContext context) {
   Map data = ModalRoute.of(context).settings.arguments;
   this.res = tryParseJwt(data['jwt']);
   this.jwt = data['jwt'];

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
       child: Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: config.bgColor,
        title: Text('Mentee task'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: config.fontColor,
          indicatorPadding: EdgeInsets.fromLTRB(35, 0, 35, 0),
          tabs: [
            Text('Repositories',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
            Text('Task details',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          ]),
      ),
      body: TabBarView(
        children: [
        SingleChildScrollView(
        child: Column(
        children: <Widget>[
        MenDet(data['name'], data['git']),
        SizedBox(height: 10),
        Text('Repositories',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        SizedBox(height: 10),
        RepoDet(data['git'], data['name'], this.jwt),
        ]
       ),
      ),

      SingleChildScrollView(
        child: Column(
        children: <Widget>[
        MenDet(data['name'], data['git']),
        SizedBox(height: 10),
        Text('Task details',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        SizedBox(height: 10),
        Graphqltemp(Stats(data['name'], data['git'], this.jwt, data['menteeroll'])), //remove unnecessary
        ]
       ),
      ),
        ]), 
      bottomNavigationBar: NavigationBar(0, this.jwt),
    ));
  }
}
