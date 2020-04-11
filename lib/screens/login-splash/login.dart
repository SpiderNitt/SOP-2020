import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inductions_20/screens/login-splash/widgets/custom_button.dart';
import 'package:inductions_20/screens/login-splash/widgets/custom_input.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00171f),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 120.0,
              ),
              Image(
                image: AssetImage(
                  'assets/images/SpiderLogo.webp',
                ),
                height: 190,
                width: 190,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 55.0, 0.0, 10.0),
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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomInput(
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
                    ),
                    CustomInput(
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
                    ),
                    CustomButton(
                      'Sign In',
                      () {
                        if (_formKey.currentState.validate()) {
                          // Process data.
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
