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
        MenDet(data['menteename'], data['git_acc']),
        SizedBox(height: 20),
        Text('Commit History for ${data['repo_det']}',  style: TextStyle( fontSize: 17, fontFamily: config.fontFamily, color: config.bordColor)),
        SizedBox(height: 20),
        Commits(data['repo_det']),
        SizedBox(height: 20),
        ]
      ),
      ),
      bottomNavigationBar: NavigationBar(0),
    );
  }
}
