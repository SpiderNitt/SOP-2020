import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inductions_20/screens/navigation/mentor_navigation.dart';
import '../../theme/mentor.dart';
import 'widgets/mentees_details.dart';
import 'widgets/mentor_details.dart';
import '../../others/jwtparse.dart';

class Mentor extends StatelessWidget {
  var name, gitacc;
  final jwt;
  var res;
  Mentor(this.jwt) {
    this.res = tryParseJwt(this.jwt);
    this.name = this.res['username'];
    this.gitacc = this.res['github_username'];
  }
  var subscription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MentorCustomDrawer(
          this.name, this.gitacc, true, false, false, false, false),
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Dashboard'),
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

  var subscription;
  StreamSubscription<ConnectivityResult> initState() {
    super.initState();
    return subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        AlertDialog alert = AlertDialog(
          title: Text("Spider Orientation"),
          content:
              Text("No internet connection. Reconnect and reopen the app."),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop('dialog');
                SystemNavigator.pop();
              },
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    });
  }

  dispose() {
    super.dispose();
    subscription.cancel();
  }

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
    );
  }
}
