import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:inductions_20/screens/enum/device_screen_type.dart';
import 'package:inductions_20/screens/ui/base_widget.dart';
import 'package:inductions_20/screens/views/widgets/custom_button.dart';
import 'package:inductions_20/screens/views/widgets/custom_input.dart';
import 'package:inductions_20/screens/views/register.dart';

final _formKey = GlobalKey<FormState>();
final _rollnocontroller = TextEditingController();
final _passwordcontroller = TextEditingController();

class Loginview extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Loginview> {
  double headingfontsize;
  double formwidth;
  double inputfieldwidth;
  double signinwidth;
  double signinheight;
  double padding;
  double fontsize;
  double imagesize;
  double containerheight;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ResponsiveBuild(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
          if (sizingInformation.orientation == Orientation.portrait) {
            headingfontsize = 25;
            imagesize = height / 4;
            containerheight = 3 * height / 8;
            formwidth = 4 * width / 5;
            inputfieldwidth = 3 * width / 4;
            signinwidth = 9 * width / 16;
            signinheight = width / 8;
            padding = 10.0;
            fontsize = 18.0;
          } else {
            headingfontsize = 25;
            containerheight = height / 2;
            imagesize = height / 4;
            formwidth = width / 2;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 9 * width / 16;
            signinheight = width / 20;
            padding = 10.0;
            fontsize = 18.0;
          }
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.LargeMobile) {
          if (sizingInformation.orientation == Orientation.portrait) {
            headingfontsize = 25;
            imagesize = height / 3;
            containerheight = height / 2;
            formwidth = 4 * width / 5;
            inputfieldwidth = 3 * width / 4;
            signinwidth = 9 * width / 16;
            signinheight = width / 8;
            padding = 10.0;
            fontsize = 18.0;
          } else {
            headingfontsize = 25;
            imagesize = height / 3;
            containerheight = height / 2;
            formwidth = width / 2;
            inputfieldwidth = 3 * width / 8;
            signinwidth = 3 * width / 8;
            signinheight = width / 10;
            padding = 10.0;
            fontsize = 18.0;
          }
        }
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    height: containerheight,
                    child: Image(
                      image: AssetImage(
                        'assets/images/SpiderLogo.webp',
                      ),
                      height: imagesize,
                      width: imagesize,
                    ),
                  ),
                ),
                Container(
                  width: formwidth,
                  color: Color(0xFF003459).withOpacity(0.5),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: Container(
                              width: inputfieldwidth,
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
                              TextInputType.number,
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
                                    var storage = new FlutterSecureStorage();
                                    await storage.write(
                                        key: "jwt", value: parsedJson.token);
                                    await Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                RegisterView()));
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
                Container(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
