import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

import 'package:inductions_20/screens/views/widgets/custom_button.dart';
import 'package:inductions_20/screens/views/widgets/custom_input.dart';
import 'package:inductions_20/screens/views/register/responsive_register_view.dart';

final _formKey = GlobalKey<FormState>();
final _webmailcontroller = TextEditingController();
final _passwordcontroller = TextEditingController();

class Login_Largemobile_Portrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Image(
            image: AssetImage(
              'assets/images/SpiderLogo.webp',
            ),
            height: height / 4,
            width: height / 4,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            width: 4 * width / 5,
            height: height / 3,
            color: Color(0xFF003459).withOpacity(0.5),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 2 * width / 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
                    padding: const EdgeInsets.all(10.0),
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
                      2 * width / 3,
                      25,
                      _passwordcontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      2 * width / 3,
                      25,
                      _webmailcontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomButton(
                      'Sign In',
                      () async {
                        if (_formKey.currentState.validate()) {
                          // set up POST request arguments
                          String url = '';
                          Map<String, String> headers = {
                            "Content-type": "application/json"
                          };
                          String webmail = _webmailcontroller.text;
                          String password = _passwordcontroller.text;
                          String json =
                              '{"rollno": $webmail, "password": $password}';
                          Response response =
                              await post(url, headers: headers, body: json);
                          int statusCode = response.statusCode;
                          String body = response.body;
                          print(body);
                        }
                      },
                      2 * width / 3,
                      width / 10,
                      25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Login_Largemobile_Landscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image(
                image: AssetImage(
                  'assets/images/SpiderLogo.webp',
                ),
                height: height / 3,
                width: height / 3,
              ),
            ),
            Container(
              width: 3 * width / 5,
              color: Color(0xFF003459).withOpacity(0.5),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: width / 2,
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Sign',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                            Text(
                              'In',
                              style: TextStyle(
                                color: Color(0xFF00A8E8),
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                        _webmailcontroller,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                            String webmail = _webmailcontroller.text;
                            String password = _passwordcontroller.text;
                            String json =
                                '{"rollno": $webmail, "password": $password}';
                            Response response =
                                await post(url, headers: headers, body: json);
                            int statusCode = response.statusCode;
                            String body = response.body;
                            print(body);
                          }
                        },
                        width / 3,
                        width / 20,
                        20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
