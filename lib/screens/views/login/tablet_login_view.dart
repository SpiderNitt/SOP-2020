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
            headingfontsize = 30;
            imagesize = height / 4;
            containerheight = height / 3;
            containerwidth = width / 2;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = width / 20;
            padding = 15.0;
            fontsize = 22.0;
          } else {
            headingfontsize = 30;
            imagesize = height / 4;
            containerheight = height / 3;
            containerwidth = width / 2;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = width / 20;
            padding = 15.0;
            fontsize = 22.0;
          }
        } else {
          if (sizingInformation.orientation == Orientation.portrait) {
            headingfontsize = 40;
            imagesize = height / 2;
            containerheight = height / 3;
            containerwidth = 2 * height / 5;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = width / 20;
            padding = 10.0;
            fontsize = 30.0;
          } else {
            headingfontsize = 40;
            imagesize = height / 4;
            containerheight = height / 4;
            containerwidth = 2 * height / 5;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = width / 20;
            padding = 10.0;
            fontsize = 30.0;
          }
        }
        return Column(
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
              child: Container(
                width: containerwidth,
                height: containerheight,
                color: Color(0xFF003459).withOpacity(0.5),
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
                        padding: EdgeInsets.all(padding),
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
                              String webmail =
                                  _rollnocontroller.text.toString();
                              String password = _passwordcontroller.text;
                              String Json =
                                  '{"rollno": $webmail, "password": $password}';
                              Response response =
                                  await post(url, headers: headers, body: Json);
                              int statusCode = response.statusCode;
                              var parsedJson = json.decode(response.body);
                              final storage = new FlutterSecureStorage();
                              await storage.write(
                                  key: "jwt", value: parsedJson.jwt);
                              print(parsedJson.message);
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
          ],
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
                      Icons.email,
                      "Webmail",
                      (value) {
                        String p =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = new RegExp(p);

                        if (value.isEmpty) {
                          return 'Enter Webmail';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Enter a valid email';
                        }

                        return null;
                      },
                      false,
                      TextInputType.emailAddress,
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
                          String url = '';
                          Map<String, String> headers = {
                            "Content-type": "application/json"
                          };
                          String webmail = _rollnocontroller.text;
                          String password = _passwordcontroller.text;
                          String json =
                              '{"rollno": "$webmail", "password": "$password"}';
                          Response response =
                              await post(url, headers: headers, body: json);
                          int statusCode = response.statusCode;
                          String body = response.body;
                          print(body);
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
