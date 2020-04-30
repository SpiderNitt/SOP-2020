import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inductions_20/others/jwtparse.dart';
import 'package:inductions_20/screens/navigation/mentor_navigation.dart';
import 'widgets/requestreviewdis.dart';
import '../../theme/mentor.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  String jwt;

  var subscription;
  @override
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

  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    print(data);
    this.jwt = data['jwt'];
    dynamic res = tryParseJwt(this.jwt);
    String name = res['username'];
    String gitacc = res['github_username'];

    return Scaffold(
      drawer: MentorCustomDrawer(
        name,
        gitacc,
        false,
        false,
        true,
        false,
        false,
      ),
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Review Requests'),
        centerTitle: true,
        backgroundColor: config.appbarcolor,
      ),
      body: SingleChildScrollView(
        child: Requestlist(this.jwt),
      ),
    );
  }
}
