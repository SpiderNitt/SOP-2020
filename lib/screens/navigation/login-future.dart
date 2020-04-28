import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:inductions_20/screens/mentor/mentor_home.dart';
import 'package:inductions_20/screens/navigation/get_details.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_button.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_input.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Files imported
import '../../theme/navigation.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}

Future<Credentials> getResponse(String rollno, String password) async {
  final http.Response response = await http.post(
    'https://spider.nitt.edu/inductions20test/login/',
    headers: <String, String>{
      'Content-type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'rollno': rollno,
      'password': password,
    }),
  );

  return Credentials.fromJson(json.decode(response.body));
}

class Credentials {
  final String rollno;
  final String password;

  Credentials({this.rollno, this.password});

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      rollno: json['rollno'],
      password: json['password'],
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginScreen> {
  Future<Credentials> _loginresponse;
  final _loginFormKey = GlobalKey<FormState>();
  final _rollnocontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  double headingfontsize;
  double inputfieldwidth;
  double signinwidth;
  double signinheight;
  double padding;
  double fontsize;
  double imagesize;
  double containerwidth;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width <= 400) {
      headingfontsize = 25;
      imagesize = 190;
      containerwidth = 300;
      inputfieldwidth = 250;
      signinwidth = 250;
      signinheight = 50;
      padding = 15.0;
      fontsize = 18.0;
    } else if (width <= 600) {
      headingfontsize = 25;
      imagesize = 190;
      containerwidth = 300;
      inputfieldwidth = 250;
      signinwidth = 250;
      signinheight = 50;
      padding = 15.0;
      fontsize = 18.0;
    } else if (width <= 900) {
      headingfontsize = 25;
      imagesize = 200;
      containerwidth = 350;
      inputfieldwidth = 300;
      signinwidth = 250;
      signinheight = 50;
      padding = 15.0;
      fontsize = 20.0;
    } else {
      headingfontsize = 25;
      imagesize = 230;
      containerwidth = 350;
      inputfieldwidth = 300;
      signinwidth = 300;
      signinheight = 50;
      padding = 15.0;
      fontsize = 20.0;
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              theme.secondaryColor,
              theme.primaryColor,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                ),
                Image(
                  image: AssetImage(
                    'assets/images/spiderIcon.png',
                  ),
                  height: imagesize * 0.7,
                  width: imagesize * 0.7,
                ),
                Container(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Container(
                    width: containerwidth,
                    child: (_loginresponse == null)
                        ? Form(
                            key: _loginFormKey,
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
                                              color: theme.fontColor,
                                              fontSize: headingfontsize,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                          Text(
                                            'In',
                                            style: TextStyle(
                                              color: theme.tertiaryColor,
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
                                  padding: EdgeInsets.fromLTRB(
                                      padding, 0.0, padding, 0.0),
                                  child: CustomButton(
                                    'Sign In',
                                    () async {
                                      if (_loginFormKey.currentState
                                          .validate()) {
                                        _loginresponse = getResponse(
                                            _rollnocontroller.text,
                                            _passwordcontroller.text);
                                      }
                                    },
                                    signinwidth,
                                    signinheight,
                                    fontsize,
                                  ),
                                ),
                                Container(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        : FutureBuilder<Credentials>(
                            future: _loginresponse,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Center(
                                  child: Text('Success'),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error'),
                                );
                              }
                              return CircularProgressIndicator();
                            },
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
