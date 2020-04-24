import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../theme/mentor.dart';
import 'dart:convert';

import 'package:inductions_20/others/jwtparse.dart';

class Data {
  List<Map> sublist;
  String status;

  Data(this.sublist);

  factory Data.model(dynamic res) {
    List<Map> temp = [];
    for (int i = 0; i < res["review_list"].length; ++i) {
      temp.add({
        "menteename": res['review_list']['$i']["mentee_name"],
        "title": res['review_list']['$i']["task_title"],
        "link": (res['review_list']['$i']["submission_links"] == "")
            ? {"0": 'No links'}
            : jsonDecode(res['review_list']['$i']["submission_links"]),
        'des': res['review_list']['$i']["submission_description"],
        'id': res['review_list']['$i']["submission_id"],
        'rflag': res['review_list']['$i']["is_reviewed"]
      });
    }
    return Data(temp);
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

class Requestlist extends StatefulWidget {
  final String mentorname, mentorgitacc, jwt;

  Requestlist(this.mentorname, this.mentorgitacc, this.jwt);

  @override
  _RequestlistState createState() =>
      _RequestlistState(this.mentorname, this.mentorgitacc, this.jwt);
}

class _RequestlistState extends State<Requestlist> {
  String mentorname, mentorgitacc, searchword = '', jwt;

  final _formkey = GlobalKey<FormState>();

  dynamic resultobt, res, mentorroll;

  _RequestlistState(this.mentorname, this.mentorgitacc, this.jwt) {
    this.mentorroll = tryParseJwt(this.jwt)['roll'];
  }

  Future<Data> getdata() async {
    Response resp = await get(
        'https://spider.nitt.edu/inductions20test/api/mentor/$mentorroll/reviewList',
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${this.jwt}'});

    if (resp.headers['status'] == '500')
      return Data.for500();
    else if (resp.headers['status'] == '403')
      return Data.for403();
    else if (resp.headers['status'] == '401')
      return Data.for401();
    else
      return Data.model(jsonDecode(resp.body));
  }

  @override
  void initState() {
    super.initState();
    this.res = getdata();
  }

  Widget submitlinks(dynamic checklinks, dynamic cont) {
    List<Widget> tempstore = [
      Text('Repo Links',
          softWrap: true,
          style: TextStyle(
              fontSize: 13,
              fontFamily: config.fontFamily,
              color: config.fontColor))
    ];

    for (int j = 0; j < checklinks['link'].length; ++j) {
      tempstore.add(
        Text(checklinks['link']['$j'],
            softWrap: true,
            style: TextStyle(
                fontSize: 13,
                fontFamily: config.fontFamily,
                color: config.links)),
      );
      tempstore.add(SizedBox(
        height: 5,
      ));
    }

    if (checklinks['rflag'] == true)
      tempstore.add(Text('Reviewed',
          softWrap: true,
          style: TextStyle(
              fontSize: 13,
              fontFamily: config.fontFamily,
              color: config.success)));
    else {
      tempstore.add(Text('Not reviewed',
          softWrap: true,
          style: TextStyle(
              fontSize: 13,
              fontFamily: config.fontFamily,
              color: config.danger)));
      tempstore.add(FlatButton(
        onPressed: () {
          Navigator.pushNamed(cont, '/writereview', arguments: {
            'repo_det': checklinks['title'],
            'id': checklinks['id'],
            'jwt': this.jwt
          });
        },
        child: Text('Write a review',
            style: TextStyle(
                fontSize: 20,
                fontFamily: config.fontFamily,
                color: config.fontColor)),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tempstore,
    );
  }

  Widget filter(dynamic contst, dynamic item) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(3),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/current.png'),
          ),
          title: Text('${item['menteename']}',
              softWrap: true,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: config.fontFamily,
                  color: config.fontColor)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Text('${item['title']}',
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: config.fontFamily,
                      color: config.fontColor)),
              SizedBox(
                height: 5,
              ),
              Text('${item['des']}',
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: config.fontFamily,
                      color: config.fontColor)),
              SizedBox(
                height: 5,
              ),
              submitlinks(item, contst),
            ],
          ),
        ),
        Divider(
          color: config.fontColor,
          indent: 70,
        ),
      ],
    );
  }

  List<Widget> listmaker(dynamic contxt) {
    List<Widget> notreview = [], reviewed = [];

    this.resultobt.forEach((element) {
      if (element['menteename'].contains(this.searchword) ||
          this.searchword == '') {
        if (element['rflag'] == true)
          reviewed.add(filter(contxt, element));
        else
          notreview.add(filter(contxt, element));
      }
    });

    notreview.addAll(reviewed);

    if (notreview.length == 0)
      notreview.add(Center(
          child: Text("No matching results",
              style: TextStyle(
                  color: config.fontColor,
                  fontSize: 20,
                  fontFamily: config.fontFamily))));

    return notreview;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.res,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status == '500')
              return Text("Server Error",
                  style: TextStyle(
                      color: config.fontColor, fontFamily: config.fontFamily));
            else if (snapshot.data.status == '401')
              return Text("Forbidden not enough rights",
                  style: TextStyle(
                      color: config.fontColor, fontFamily: config.fontFamily));
            else if (snapshot.data.status == '403')
              return Text("Unauthorized",
                  style: TextStyle(
                      color: config.fontColor, fontFamily: config.fontFamily));
            else {
              this.resultobt = snapshot.data.sublist;
              return Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formkey,
                      child: TextFormField(
                        cursorColor: config.fontColor,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: config.fontFamily,
                            color: config.fontColor),
                        maxLines: null,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: config.bordWid,
                              color: config.fontColor,
                            ),
                          ),
                          labelText: 'Search',
                          labelStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: config.fontFamily,
                              color: config.fontColor),
                        ),
                        onChanged: (String value) {
                          this.setState(() {
                            searchword = value;
                          });
                        },
                      ),
                    ),
                    Divider(
                      color: config.fontColor,
                    ),
                    Container(
                      child: Column(
                        children: listmaker(context),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (snapshot.hasError)
            return Center(
                child: Text(
              "${snapshot.error}",
              style: TextStyle(color: config.fontColor),
            ));
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }
}
