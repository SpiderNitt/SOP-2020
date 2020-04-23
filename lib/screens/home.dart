import 'package:flutter/material.dart';
import '../others/config.dart';
import '../widgets/mentees_details.dart';
import '../widgets/navigationbar.dart';
import '../widgets/mentor_details.dart';
import '../others/jwtparse.dart';

class Home extends StatefulWidget {

String name, gitacc, jwt;
dynamic res;

  Home(this.jwt){
   this.res = tryParseJwt(this.jwt);
   this.name = this.res['username'];
   this.gitacc = this.res['github_username'];
  }

  @override
  _HomeState createState() => _HomeState(this.name, this.gitacc, this.jwt);
}

class _HomeState extends State<Home> {

String name, gitacc, jwt;
 
  _HomeState(this.name, this.gitacc, this.jwt);
 
  @override

  Widget build(BuildContext context) {
//      Map data = ModalRoute.of(context).settings.arguments;
//      this.jwt = data['jwt'];
//      this.res =  tryParseJwt(this.jwt);
//      this.name = this.res['username'];
//      this.gitacc = this.res['github_username'];
//
    return Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Mentor Page'),
        centerTitle: true,
        backgroundColor: config.appbarcolor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child : Column(
      children: <Widget>[
        MenDet(this.name, this.gitacc),
        SizedBox(height: 10),
        Text('Mentee details',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        SizedBox(height: 15),
        MenteeDet(this.jwt) 
      ],
      ),
        ),
        ),
      bottomNavigationBar: NavigationBar(0,this.jwt),
    );
  }
}


