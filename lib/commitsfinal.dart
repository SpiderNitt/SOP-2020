import 'package:flutter/material.dart';
import 'commits.dart';
import 'mentor_details.dart';
import 'navigationbar.dart';
import 'config.dart';

class CommitsFinal extends StatefulWidget {
  @override
  _CommitsFinal createState() => _CommitsFinal();
}

class _CommitsFinal extends State<CommitsFinal> {
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
        backgroundColor: config.appbarcolor,
        title: Text('Mentee task'),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Column(
        children: <Widget>[
        MenDet(data['menteename'], data['git_acc']),
        Container(
          padding: EdgeInsets.all(20),
         child: Center(
           child: Text('Commit History for ${data['repo_det']}',  style: TextStyle( fontSize: 17, fontFamily: config.fontFamily, color: config.fontColor)),
         ),
        ),
        Commits(data['repo_det'], data['git_acc']),
        SizedBox(height: 20),
        ]
      ),
      ),
      bottomNavigationBar: NavigationBar(0, this.jwt),
    );
  }
}
