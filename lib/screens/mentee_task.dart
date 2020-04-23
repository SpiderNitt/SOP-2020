import 'package:flutter/material.dart';
import '../widgets/stats.dart';
import '../widgets/mentor_details.dart';
import '../widgets/navigationbar.dart';
import '../widgets/repodet.dart';
import '../others/config.dart';

class MenteeTask extends StatefulWidget {

  @override
  _MenteeTaskState createState() => _MenteeTaskState();
}

class _MenteeTaskState extends State<MenteeTask> {
  
  dynamic res; 


  @override
  Widget build(BuildContext context) {
   Map data = ModalRoute.of(context).settings.arguments;
    
    if(data['git'] == '')
    return Scaffold(
      backgroundColor: config.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Mentee Task'),
        centerTitle: true,
        backgroundColor: config.appbarcolor,
      ),
      body: Center(
        child: Text('Mentee Github account not found',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor))),
      bottomNavigationBar: NavigationBar(0, data['jwt']),
    );
    
    else
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
       child: Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
         automaticallyImplyLeading: false,
          elevation: 0,
           backgroundColor: config.appbarcolor,
        title: Text('Mentee task'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: config.tab,
          tabs: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('Repositories',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
            ), 
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('Task details',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
            ), 
            
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
        RepoDet(data['git'], data['name'], data['jwt']),
        ]
       ),
      ),

      SingleChildScrollView(
        child: Column(
        children: <Widget>[
        SizedBox(height: 20),  
        Text('Task details',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        SizedBox(height: 10),
        Stats(data['name'], data['git'], data['jwt'], data['menteeroll']), //remove unnecessary
        ]
       ),
      ),
        ]), 
      bottomNavigationBar: NavigationBar(0, data['jwt']),
    ));
  }
}
