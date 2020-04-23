import 'dart:io';
import 'package:flutter/material.dart';
import '../others/config.dart';
import '../others/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data {
  List<Map> menteenames;
  dynamic status;

  Data(this.menteenames, this.status);

  factory Data.model(dynamic res, dynamic stat) {
    List<Map> temp = [];
    for (int i = 0; i < res['mentee_list'].length; ++i) {
      temp.add({
        "mentee_name": res['mentee_list']['$i']['mentee_name'],
        "mentee_roll": res['mentee_list']['$i']['mentee_roll'],
        "github_username": res['mentee_list']['$i']['github_username'],
      });
    }
    return Data(temp, stat);
  }

  Data.for500() {
    this.status = '500';
  }
  Data.for403() {
    this.status = '403';
  }

  Data.for401() {
    this.status = '401';
  }
}

class MenteeDet extends StatefulWidget {
  String jwttoken;
  MenteeDet(this.jwttoken);

  @override
  _MenteeDetState createState() => _MenteeDetState(this.jwttoken);
}

class _MenteeDetState extends State<MenteeDet> {
  String jwttoken, rollno;
  dynamic res;

  _MenteeDetState(this.jwttoken) {
    this.rollno = tryParseJwt(this.jwttoken)['roll'];
  }

  Future<Data> getdata() async {
    Response resp = await get(
        'https://spider.nitt.edu/inductions20test/api/mentor/${this.rollno}/menteeList',
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${this.jwttoken}'});

    if (resp.headers['status'] == '500')
      return Data.for500();
    else if (resp.headers['status'] == '403')
      return Data.for403();
    else if (resp.headers['status'] == '401')
      return Data.for401();
    else
      return Data.model(jsonDecode(resp.body), resp.headers['status']);
  }

  @override
  void initState() {
    super.initState();
    this.res = getdata();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.res,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status == '500')
              return Text(
                "Server Error",
                style: TextStyle(
                    color: config.fontColor,
                    fontFamily: config.fontFamily,
                    fontSize: 18),
              );
            else if (snapshot.data.status == '401')
              return Text(
                "Forbidden not enough rights",
                style: TextStyle(
                    color: config.fontColor,
                    fontFamily: config.fontFamily,
                    fontSize: 18),
              );
            else if (snapshot.data.status == '403')
              return Text(
                "Unauthorized",
                style: TextStyle(
                    color: config.fontColor,
                    fontFamily: config.fontFamily,
                    fontSize: 18),
              );
            else
              return Container(
                constraints: BoxConstraints(
                  minHeight: 5.0,
                  maxHeight: 390.0,
                ),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView.builder(
                    itemCount: snapshot.data.menteenames.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            trailing: Icon(
                              Icons.keyboard_arrow_right,
                              color: config.fontColor,
                            ),
                            contentPadding: EdgeInsets.all(3),
                            onTap: () {
                              Navigator.pushNamed(context, '/menteetask',
                                  arguments: {
                                    'name': snapshot.data.menteenames[index]
                                        ['mentee_name'],
                                    'git': snapshot.data.menteenames[index]
                                        ['github_username'],
                                    'jwt': this.jwttoken,
                                    'menteeroll': snapshot
                                        .data.menteenames[index]['mentee_roll'],
                                  });
                            },
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/android.png'),
                            ),
                            title: Text(
                                '${snapshot.data.menteenames[index]['mentee_name']}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: config.fontFamily,
                                    color: config.fontColor)),
                          ),
                          Divider(
                            color: config.fontColor,
                            indent: 70,
                          ),
                        ],
                      );
                    }),
              );
          } else if (snapshot.hasError) {
            return Text(
              "${snapshot.error}",
              style: TextStyle(
                  color: config.fontColor,
                  fontSize: 20,
                  fontFamily: config.fontFamily),
            );
          } else
            return CircularProgressIndicator();
        });
  }
}
