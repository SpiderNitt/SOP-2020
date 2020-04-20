import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Files imported
import 'package:inductions_20/screens/widgets/custom_button.dart';
import 'package:inductions_20/screens/widgets/custom_input.dart';

final _formKey = GlobalKey<FormState>();
final _rollnocontroller = TextEditingController();
final _passwordcontroller = TextEditingController();

class LoginView extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
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

    if (width <= 400) {
      headingfontsize = 22;
      imagesize = 190;
      containerheight = height / 3;
      containerwidth = 300;
      inputfieldwidth = 200;
      signinwidth = 200;
      signinheight = 60;
      padding = 15.0;
      fontsize = 18.0;
    } else if (width <= 600) {
      headingfontsize = 22;
      imagesize = 190;
      containerheight = height / 3;
      containerwidth = 300;
      inputfieldwidth = 200;
      signinwidth = 200;
      signinheight = 60;
      padding = 15.0;
      fontsize = 18.0;
    } else if (width <= 900) {
      headingfontsize = 25;
      imagesize = 200;
      containerheight = height / 3;
      containerwidth = 300;
      inputfieldwidth = 250;
      signinwidth = 250;
      signinheight = 60;
      padding = 15.0;
      fontsize = 20.0;
    } else {
      headingfontsize = 25;
      imagesize = 230;
      containerheight = height / 4;
      containerwidth = 300;
      inputfieldwidth = 3 * width / 8;
      signinwidth = 3 * width / 8;
      signinheight = 60;
      padding = 15.0;
      fontsize = 20.0;
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              Color(0xFF003459),
              Color(0xFF00171f),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage(
                    'assets/images/SpiderLogo.webp',
                  ),
                  height: imagesize,
                  width: imagesize,
                ),
                Container(
                  height: 50,
                ),
                Padding(
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
                              "Roll number",
                              (value) {
                                if (value.isEmpty) {
                                  return 'Enter roll number';
                                } else if (!isNumeric(value)) {
                                  return 'Enter a valid roll number';
                                } else if (value.toString().length > 9 ||
                                    value.toString().length < 9) {
                                  return 'Enter a valid roll number';
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
                                  return 'Enter password';
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
                                  int statusCode = response.statusCode;
                                  var parsedJson = json.decode(response.body);
                                  if (parsedJson["success"] == true) {
                                    // direct to mentor page or mentee page based on jwt
                                    final String jwt = parsedJson["token"];
                                    final storage = new FlutterSecureStorage();
                                    await storage.write(
                                        key: "jwt", value: "$jwt");
                                  } else {
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Spider Orientation"),
                                      content: Text(
                                          "Incorrect roll number and password"),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                padding, padding, 0.0, padding),
                            child: Center(
                              child: Text(
                                'Enter your webmail roll number and password',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
