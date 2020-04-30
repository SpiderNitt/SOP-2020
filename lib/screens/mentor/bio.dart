import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inductions_20/screens/navigation/mentor_navigation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../others/jwtparse.dart';
import '../../theme/mentor.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Bio extends StatefulWidget {
  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  final _formkey = GlobalKey<FormState>();
  String name, gitacc, password, githubacc, year = '', dept, jwt, mentorroll;
  var subscription;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
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
    update();
  }

  dispose() {
    super.dispose();
    subscription.cancel();
  }

  Future<void> update() async {
    final storage = new FlutterSecureStorage();
    String jwttoken = await storage.read(key: 'jwt');
    dynamic result = tryParseJwt(jwttoken);
    setState(() {
      this.name = result['username'];
      this.gitacc = result['github_username'];
      this.jwt = jwttoken;
      this.mentorroll = result["roll"];
    });
  }

  @override
  Widget build(BuildContext context) {
//    Map data = ModalRoute.of(context).settings.arguments;
//    this.jwt = data['jwt'];
//    dynamic res = tryParseJwt(this.jwt);
//    name = res['username'];
//    gitacc = res['github_username'];
//    this.mentorroll = res["roll"];

    return Scaffold(
      drawer:
          MentorCustomDrawer(name, gitacc, false, false, false, true, false),
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
                      child: new Text(
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
                    SizedBox(height: 25),
                    FlatButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            String githubUsername = this.name;
                            Response apiResponse = await get(
                                "https://api.github.com/users/$githubUsername");
                            if (apiResponse.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    body: Container(
                                      color: config.bgColor,
                                      child: Center(
                                        child: SpinKitPouringHourglass(
                                          color: Colors.white,
                                          size: 70.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              final storage = new FlutterSecureStorage();
                              password = await storage.read(key: "password");
                              post(
                                  'https://spider.nitt.edu/inductions20test/api/update_github_username',
                                  headers: {
                                    HttpHeaders.authorizationHeader:
                                        'Bearer ${this.jwt}'
                                  },
                                  body: jsonEncode({
                                    "rollno": '${this.mentorroll}',
                                    "github_username": this.name
                                  })).then((Response value) async {
                                post(
                                    'https://spider.nitt.edu/inductions20test/login/',
                                    headers: {
                                      HttpHeaders.authorizationHeader:
                                          'Bearer ${this.jwt}'
                                    },
                                    body: jsonEncode({
                                      "rollno": '${this.mentorroll}',
                                      "password": password
                                    })).then((Response response) async {
                                  var parsedJson =
                                      await json.decode(response.body);
                                  final String token = parsedJson["jwt"];
                                  await storage.write(
                                      key: "jwt", value: "$token");
                                  await update();
                                });
                                Navigator.pop(context);
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
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: config.success,
                                content: Text('Invalid github username',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: config.fontFamily,
                                        color: config.fontColor)),
                              ));
                            }
                          }
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
