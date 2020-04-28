import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/navigation/mentee_navigation.dart';

import '../../theme/mentor.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'config/jwtparse.dart';
import 'config/extractjwt.dart';

class Biomentee extends StatefulWidget {
  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Biomentee> {
  final _formkey = GlobalKey<FormState>();
  String name, githubacc, year = '', dept, jwt, mentorroll;
  var user;
  String username = " ";
  void initState() {
    this.user = {
      "name": "loading..",
      "avatar_url":
          "https://media-exp1.licdn.com/dms/image/C510BAQG9qrZT4zZUUA/company-logo_200_200/0?e=2159024400&v=beta&t=nv5kv0k1DSSLrKxY2fLQ4YEsfZGvQ-XJ8Ypiu66RqaA",
      "login": "loading.."
    };
    makeRequest();
  }

  Future<void> makeRequest() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    var jwt = provideJwt.jwt;

    var res = tryParseJwt(jwt);
    setState(() {
      username = res['github_username'];
    });

    try {
      String url = 'https://api.github.com/users/';
      http.Response response = await http.get(Uri.encodeFull(url + username),
          headers: {"Accept": "application/json"});
      var user1 = await json.decode(response.body);
      setState(() {
        this.user = user1;
      });
    } catch (e) {
      print("exception error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    this.jwt = data['jwt'];
    dynamic res = tryParseJwt(this.jwt);
    String name = res['username'];
    String gitacc = res['github_username'];

    this.mentorroll = res["roll"];

    return Scaffold(
      drawer: MenteeCustomDrawer(
        '$name',
        gitacc,
        '${this.user["avatar_url"]}',
        false,
        false,
        true,
      ),
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Update Github username'),
        centerTitle: true,
        backgroundColor: config.appbarcolor,
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Current Github Username: ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: config.fontFamily,
                          color: config.fontColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "$gitacc",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: config.fontFamily,
                          color: Color(0xFF00A8E8),
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: config.fontColor,
                      ),
                      cursorColor: config.fontColor,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: config.bordWid,
                            color: config.fontColor,
                          ),
                        ),
                        labelText: 'Github username',
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: config.fontFamily,
                            color: config.fontColor),
                      ),
                      maxLines: null,
                      validator: (String value) {
                        if (value.isEmpty)
                          return 'Please enter your username';
                        else {
                          this.name = value;
                          return null;
                        }
                      },
                    ),
                    // SizedBox(height: 15),
                    // TextFormField(
                    //   style: TextStyle(
                    //     color: config.fontColor,
                    //   ),
                    //   cursorColor: config.fontColor,
                    //   decoration: InputDecoration(
                    //     focusedBorder: OutlineInputBorder(
                    //        borderSide: BorderSide(
                    //          width: config.bordWid,
                    //          color: config.fontColor,
                    //        ),
                    //      ),
                    //     labelText: 'Dept',
                    //     labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
                    //     ),
                    //   maxLines: null,
                    //   validator: (String value){
                    //     if(value.isEmpty)
                    //     return 'Enter your Dept';
                    //     else{
                    //      this.setState((){
                    //         this.dept = value;
                    //     });
                    //     return null;
                    //     }
                    //   },
                    // ),
                    // SizedBox(height: 15),
                    // TextFormField(
                    //    style: TextStyle(
                    //     color: config.fontColor,
                    //   ),
                    //   cursorColor: config.fontColor,
                    //   decoration: InputDecoration(
                    //     focusedBorder: OutlineInputBorder(
                    //        borderSide: BorderSide(
                    //          width: config.bordWid,
                    //          color: config.fontColor,
                    //        ),
                    //      ),
                    //     labelText: 'Github account',
                    //     labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
                    //     ),
                    //   maxLines: null,
                    //   validator: (String value){
                    //     if(value.isEmpty)
                    //     return 'Enter your Github account';
                    //      else{
                    //       this.setState((){
                    //         this.githubacc = value;
                    //       });
                    //       return null;
                    //     }
                    //   },
                    // ),
                    //  SizedBox(height: 15),
                    //  TextFormField(
                    //     style: TextStyle(
                    //     color: config.fontColor,
                    //   ),
                    //   cursorColor: config.fontColor,
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     focusedBorder: OutlineInputBorder(
                    //        borderSide: BorderSide(
                    //          width: config.bordWid,
                    //          color: config.fontColor,
                    //        ),
                    //      ),
                    //     labelText: 'Year',
                    //     labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
                    //     hintText: '',
                    //     ),
                    //   maxLines: null,
                    //   validator: (String value){
                    //     int data = int.tryParse(value);
                    //      if (value.isEmpty)
                    //         return 'Please enter year';
                    //      else if (data <= 0 || data > 4)
                    //         return 'Please enter a correct year';
                    //       else{
                    //       this.setState((){
                    //         this.year = value;
                    //       });
                    //       return null;
                    //     }
                    //   },
                    // ),
                    SizedBox(height: 25),
                    FlatButton(
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            post(
                                'https://spider.nitt.edu/inductions20test/api/update_github_username',
                                headers: {
                                  HttpHeaders.authorizationHeader:
                                      'Bearer ${this.jwt}'
                                },
                                body: jsonEncode({
                                  "rollno": '${this.mentorroll}',
                                  "github_username": this.name
                                })).then((Response value) {
                              print(value.statusCode);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: config.success,
                                content: Text('Submitted',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: config.fontFamily,
                                        color: config.fontColor)),
                              ));
                            }).catchError((Response error) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: config.danger,
                                content: Text('Server Error',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: config.fontFamily,
                                        color: config.fontColor)),
                              ));
                            });
                          } else
                            print('failure');
                        },
                        child: Text('Submit',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: config.fontFamily,
                                color: config.fontColor))),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
