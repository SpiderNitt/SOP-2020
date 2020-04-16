import 'dart:html';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:inductions_20/screens/ui/base_widget.dart';
import 'package:inductions_20/screens/enum/device_screen_type.dart';
import 'package:inductions_20/screens/ui/base_widget.dart';
import 'package:inductions_20/screens/views/widgets/custom_button.dart';
import 'package:inductions_20/screens/views/widgets/custom_input.dart';
import 'package:inductions_20/screens/views/register.dart';

final _formKey = GlobalKey<FormState>();
final _rollnocontroller = TextEditingController();
final _passwordcontroller = TextEditingController();

class Logintablet extends StatefulWidget {
  @override
  LogintabletState createState() => LogintabletState();
}

class LogintabletState extends State<Logintablet> {
  double headingfontsize;
  double inputfieldwidth;
  double signinwidth;
  double signinheight;
  double padding;
  double fontsize;
  double imagesize;
  double containerheight;
  double containerwidth;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ResponsiveBuild(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          if (sizingInformation.orientation == Orientation.portrait) {
            headingfontsize = 25;
            imagesize = 200;
            containerheight = height / 3;
            containerwidth = width / 2;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = 60;
            padding = 15.0;
            fontsize = 20.0;
          } else {
            headingfontsize = 25;
            imagesize = 200;
            containerheight = height / 4;
            containerwidth = width / 2;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = 60;
            padding = 15.0;
            fontsize = 20.0;
          }
        } else {
          if (sizingInformation.orientation == Orientation.portrait) {
            headingfontsize = 25;
            imagesize = 230;
            containerheight = height / 4;
            containerwidth = 2 * height / 5;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = 60;
            padding = 15.0;
            fontsize = 20.0;
          } else {
            headingfontsize = 25;
            imagesize = 230;
            containerheight = height / 4;
            containerwidth = 2 * height / 5;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = 60;
            padding = 15.0;
            fontsize = 20.0;
          }
        }
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image(
                  image: AssetImage(
                    'assets/images/SpiderLogo.webp',
                  ),
                  height: imagesize,
                  width: imagesize,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Container(
                    width: containerwidth,
                    color: Color(0xFF003459),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: inputfieldwidth,
                              child: Padding(
                                padding: EdgeInsets.all(padding),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Sign',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: headingfontsize,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    Text(
                                      'In',
                                      style: TextStyle(
                                        color: Color(0xFF00A8E8),
                                        fontSize: headingfontsize,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: CustomInput(
                              Icons.person,
                              "Rollnumber",
                              (value) {
                                if (value.isEmpty) {
                                  return 'Enter Rollnumber';
                                } else if (value.toString().length > 9 ||
                                    value.toString().length < 9) {
                                  return 'Enter a valid rollnumber';
                                }
                                return null;
                              },
                              false,
                              TextInputType.emailAddress,
                              inputfieldwidth,
                              fontsize,
                              _rollnocontroller,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: CustomInput(
                              Icons.lock,
                              "Password",
                              (value) {
                                if (value.isEmpty) {
                                  return 'Enter Password';
                                }
                                return null;
                              },
                              true,
                              TextInputType.text,
                              inputfieldwidth,
                              fontsize,
                              _passwordcontroller,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
                            child: CustomButton(
                              'Sign In',
                              () async {
                                if (_formKey.currentState.validate()) {
                                  // set up POST request arguments
                                  String url =
                                      "https://spider.nitt.edu/inductions20/login";
                                  Map<String, String> headers = {
                                    "Content-type": "application/json",
                                  };
                                  String rollno =
                                      _rollnocontroller.text.toString();
                                  String password = _passwordcontroller.text;
                                  String Json =
                                      '{"rollno": "$rollno", "password": "$password"}';
                                  Response response = await post(url,
                                      headers: headers, body: Json);
                                  print(response.body);
                                  int statusCode = response.statusCode;
                                  var parsedJson = json.decode(response.body);
                                  if (parsedJson["success"] == true) {
//                                    var storage = new FlutterSecureStorage();
//                                    await storage.write(
//                                        key: "jwt", value: parsedJson.token);
                                    final Storage _localStorage =
                                        window.localStorage;

                                    _localStorage['jwt'] = parsedJson["token"];

                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterView()),
                                    );
                                    print(parsedJson.message);
                                  } else {
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Spider Inductions"),
                                      content:
                                          Text("Invalid username and password"),
                                      actions: [
                                        FlatButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
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
                                }
                              },
                              signinwidth,
                              signinheight,
                              fontsize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

class Login_Tablet_Landscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width;
    final width = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Image(
              image: AssetImage(
                'assets/images/SpiderLogo.webp',
              ),
              height: height / 4,
              width: height / 4,
            ),
          ),
          Container(
            width: 2 * height / 5,
            height: height / 3,
            color: Color(0xFF003459).withOpacity(0.5),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: width / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Sign',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                            Text(
                              'In',
                              style: TextStyle(
                                color: Color(0xFF00A8E8),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomInput(
                      Icons.person,
                      "Rollno",
                      (value) {
                        if (value.isEmpty) {
                          return 'Enter Rollnumber';
                        } else if (value.toString().length > 9 ||
                            value.toString().length < 9) {
                          return 'Enter a valid rollnumber';
                        }
                        return null;
                      },
                      false,
                      TextInputType.number,
                      width / 2,
                      20,
                      _rollnocontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomInput(
                      Icons.lock,
                      "Password",
                      (value) {
                        if (value.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                      true,
                      TextInputType.text,
                      width / 2,
                      20,
                      _passwordcontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomButton(
                      'Sign In',
                      () async {
                        if (_formKey.currentState.validate()) {
                          // set up POST request arguments
                          String url =
                              "https://spider.nitt.edu/inductions20/login";
                          Map<String, String> headers = {
                            "Content-type": "application/json"
                          };
                          String rollno = _rollnocontroller.text.toString();
                          String password = _passwordcontroller.text;
                          String Json =
                              '{"rollno": "$rollno", "password": "$password"}';
                          Response response =
                              await post(url, headers: headers, body: Json);
                          print(response.body);
                          int statusCode = response.statusCode;
                          var parsedJson = json.decode(response.body);
                          if (parsedJson["success"] == true) {
//                            var storage = new FlutterSecureStorage();
//                            await storage.write(
//                                key: "jwt", value: parsedJson.token);
                            final Storage _localStorage = window.localStorage;

                            _localStorage['jwt'] = parsedJson["token"];
                            await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RegisterView()));
                            print(parsedJson.message);
                          } else {
                            AlertDialog alert = AlertDialog(
                              title: Text("Spider Inductions"),
                              content: Text("Invalid username and password"),
                              actions: [
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
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
                        }
                      },
                      2 * width / 5,
                      width / 15,
                      25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
