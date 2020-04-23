import 'package:flutter/material.dart';
import 'package:inductions_20/others/jwtparse.dart';
import 'package:inductions_20/screens/mentor_navigation.dart';
import '../widgets/requestreviewdis.dart';
import '../others/config.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  String jwt;

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    print(data);
    this.jwt = data['jwt'];
    dynamic res = tryParseJwt(this.jwt);
    String name = res['username'];
    String gitacc = res['github_username'];

    return Scaffold(
      drawer: MentorCustomDrawer(name, gitacc),
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Review Requests'),
        centerTitle: true,
        backgroundColor: config.appbarcolor,
      ),
      body: SingleChildScrollView(
        child: Requestlist('anish', 'chakki1234', this.jwt),
      ),
    );
  }
}
