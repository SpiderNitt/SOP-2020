import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/mentor_navigation.dart';
import '../others/jwtparse.dart';
import '../others/config.dart';
import '../widgets/navigationbar.dart';
import 'package:http/http.dart';

class Bio extends StatefulWidget {
  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  final _formkey = GlobalKey<FormState>();
  String name, githubacc, year = '', dept, jwt, mentorroll;

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    this.jwt = data['jwt'];
    dynamic res = tryParseJwt(this.jwt);
    String name = res['username'];
    String gitacc = res['github_username'];
    this.mentorroll = res["roll"];

    return Scaffold(
      drawer: MentorCustomDrawer(name, gitacc),
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
      bottomNavigationBar: NavigationBar(2, this.jwt),
    );
  }
}
