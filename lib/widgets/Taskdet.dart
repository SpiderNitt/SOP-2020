import 'dart:io';
import 'package:flutter/material.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TaskDet extends StatefulWidget {
  final String _jwttoken;
  final List _profiles;
  TaskDet(this._jwttoken, this._profiles);

  @override
  _TaskDetState createState() => _TaskDetState(this._jwttoken, this._profiles);
}

class _TaskDetState extends State<TaskDet> {
  String jwttoken;
  dynamic res;
  List<dynamic> profiles;

  _TaskDetState(this.jwttoken, this.profiles);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView.builder(
            itemCount: this.profiles.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                  future: get(
                      'https://spider.nitt.edu/inductions20test/api/profile/${this.profiles[index]}',
                      headers: {
                        HttpHeaders.authorizationHeader:
                            'Bearer ${this.jwttoken}'
                      }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic temp = jsonDecode(snapshot.data.body);

                      List<Widget> tempwid = [];

                      if (temp['tasks'].length != 0) {
                        for (int j = 0; j < temp['tasks'].length; ++j) {
                          tempwid.add(Container(
                              child: Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(temp['tasks']['$j']['profile_task_count'],
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: config.fontFamily,
                                      color: config.links)),
                              SizedBox(height: 5),
                              Text(temp['tasks']['$j']['task_title'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: config.fontFamily,
                                      color: config.success)),
                              SizedBox(height: 10),
                              FutureBuilder(
                                  future: get(
                                      'https://spider.nitt.edu/inductions20test/api/task/${temp['tasks']['$j']['task_id']}',
                                      headers: {
                                        HttpHeaders.authorizationHeader:
                                            'Bearer ${this.jwttoken}'
                                      }),
                                  builder: (context, snapst) {
                                    if (snapst.hasData) {
                                      dynamic tempdes =
                                          jsonDecode(snapst.data.body);
                                      return Text(tempdes['task_description'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: config.fontFamily,
                                              color: config.fontColor));
                                    }

                                    if (snapst.hasError) {
                                      return Text('${snapst.error}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: config.fontFamily,
                                              color: config.fontColor));
                                    } else
                                      return CircularProgressIndicator();
                                  }),
                              Divider(color: config.fontColor)
                            ],
                          )));
                        }

                        return Column(children: tempwid);
                      } else
                        return Text('No data found',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: config.fontFamily,
                                color: config.fontColor));
                    }

                    if (snapshot.hasError)
                      return Text('${snapshot.error}',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: config.fontFamily,
                              color: config.fontColor));
                    else
                      return CircularProgressIndicator();
                  });
            }));
  }
}
