import 'package:flutter/material.dart';
import '../others/config.dart';
import '../widgets/mentees_details.dart';
// import '../widgets/navigationbar.dart';
import '../widgets/mentor_details.dart';
import '../others/jwtparse.dart';
import 'mentor_navigation.dart';

class Mentor extends StatelessWidget {
  String name, gitacc, jwt;
  dynamic res;
  Mentor(this.jwt) {
    this.res = tryParseJwt(this.jwt);
    this.name = this.res['username'];
    this.gitacc = this.res['github_username'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MentorCustomDrawer(this.name, this.gitacc),
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Mentor Page'),
        centerTitle: true,
        backgroundColor: config.appbarcolor,
      ),
      body: MentorHome(this.jwt),
    );
  }
}

class MentorHome extends StatefulWidget {
  String name, gitacc, jwt;
  dynamic res;

  MentorHome(this.jwt) {
    this.res = tryParseJwt(this.jwt);
    this.name = this.res['username'];
    this.gitacc = this.res['github_username'];
  }

  @override
  _MentorHomeState createState() =>
      _MentorHomeState(this.name, this.gitacc, this.jwt);
}

class _MentorHomeState extends State<MentorHome> {
  String name, gitacc, jwt;

  _MentorHomeState(this.name, this.gitacc, this.jwt);

  @override
  Widget build(BuildContext context) {
//      Map data = ModalRoute.of(context).settings.arguments;
//      this.jwt = data['jwt'];
//      this.res =  tryParseJwt(this.jwt);
//      this.name = this.res['username'];
//      this.gitacc = this.res['github_username'];
//
    // return Scaffold(
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            MenDet(this.name, this.gitacc),
            SizedBox(height: 10),
            Text('Mentee details',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: config.fontFamily,
                    color: config.fontColor)),
            SizedBox(height: 15),
            MenteeDet(this.jwt)
          ],
        ),
        // ),
      ),
      // bottomNavigationBar: NavigationBar(0, this.jwt),
    );
  }
}
