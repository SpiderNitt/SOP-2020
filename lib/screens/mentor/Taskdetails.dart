import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/navigation/mentor_navigation.dart';
import '../../theme/mentor.dart';
import '../../others/jwtparse.dart';
import 'widgets/Taskdet.dart';
import 'package:http/http.dart';

class Tasklist extends StatefulWidget {
  @override
  _TasklistState createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  String jwt, roll;
  List<dynamic> profiles = [];
  dynamic res;
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    this.jwt = data['jwt'];
    this.res = tryParseJwt(this.jwt);
    this.roll = this.res["roll"];

    return Scaffold(
      drawer: MentorCustomDrawer(
        this.res["username"],
        this.res["github_username"],
        false,
        true,
        false,
        false,
      ),
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Task details'),
        centerTitle: true,
        backgroundColor: config.appbarcolor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: get(
                'https://spider.nitt.edu/inductions20test/api/mentor/${this.roll}/profile',
                headers: {
                  HttpHeaders.authorizationHeader: 'Bearer ${this.jwt}'
                }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                try {
                  this.profiles = [];
                  dynamic temp = jsonDecode(snapshot.data.body);
                  for (int i = 0; i < temp["profile_ids"].length; ++i) {
                    this.profiles.add(temp["profile_ids"]['$i']);
                  }

                  return TaskDet(this.jwt, this.profiles);
                } catch (e) {
                  return Center(
                      child: Text('$e',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: config.fontFamily,
                              color: config.fontColor)));
                }
              }

              if (snapshot.hasError) {
                return Text('${snapshot.error}',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: config.fontFamily,
                        color: config.fontColor));
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
