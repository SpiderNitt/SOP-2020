import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
                  'images/SpiderLogo.webp',
                ),
                height: 130,
                width: 130,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 10.0),
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

class CustomInput extends StatelessWidget {
  IconData icon;
  String hintText;
  Function validator;
  bool obscureText;
  TextInputType type;

  CustomInput(
      this.icon, this.hintText, this.validator, this.obscureText, this.type);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: TextFormField(
        keyboardType: type,
        obscureText: obscureText,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 20,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Color(0xFF00A8E8),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
          ),
          errorStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
          ),
          fillColor: Color(0xFF00A8E8).withOpacity(0.1),
          filled: true,
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF00A8E8),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF00A8E8),
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF00A8E8),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  String text;
  Function submit;

  CustomButton(this.text, this.submit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 0),
      child: InkWell(
        onTap: submit,
        focusColor: Color(0xFF00171f),
        highlightColor: Color(0xFF00171f),
        splashColor: Color(0xFF00A8E8),
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        child: Container(
          height: 50.0,
          width: 280.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            border: Border.all(
              width: 1.5,
              color: Color(0xFF00A8E8),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
