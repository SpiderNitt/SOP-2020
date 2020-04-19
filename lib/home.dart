import 'package:flutter/material.dart';
import 'package:inductions_20/graphqltemp.dart';
import 'config.dart';
import 'mentees_details.dart';
import 'navigationbar.dart';
import 'mentor_details.dart';
import 'jwtparse.dart';

class Home extends StatefulWidget {

String name, gitacc, jwt;
dynamic res;

  Home(this.jwt){
   this.res = tryParseJwt(this.jwt);
   this.name = this.res['name'];
   this.gitacc = 'chakki1234';
  }

  @override
  _HomeState createState() => _HomeState(this.name, this.gitacc, this.jwt);
}

class _HomeState extends State<Home> {

String name, gitacc, jwt;
 
  _HomeState(this.name, this.gitacc, this.jwt);
 
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
        SizedBox(height: 15),
        Graphqltemp(MenteeDet(this.jwt)) 
      ],
      ),
        ),
        ),
      bottomNavigationBar: NavigationBar(0,this.jwt),
    );
  }
}


