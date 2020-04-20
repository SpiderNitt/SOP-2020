import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Files imported
import 'package:inductions_20/screens/widgets/custom_button.dart';
import 'package:inductions_20/screens/widgets/custom_input.dart';

final _formKey = GlobalKey<FormState>();
final _github_username_controller = TextEditingController();

class GetGithubUsernameView extends StatefulWidget {
  @override
  ViewState createState() => ViewState();
}

class ViewState extends State<GetGithubUsernameView> {
  double inputfieldwidth;
  double submitwidth;
  double submitheight;
  double padding;
  double fontsize;
  double containerwidth;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (width <= 400) {
      containerwidth = 300;
      inputfieldwidth = 250;
      submitwidth = 200;
      submitheight = 50;
      padding = 15.0;
      fontsize = 18.0;
    } else if (width <= 600) {
      containerwidth = 300;
      inputfieldwidth = 250;
      submitwidth = 200;
      submitheight = 50;
      padding = 15.0;
      fontsize = 18.0;
    } else if (width <= 900) {
      containerwidth = 300;
      inputfieldwidth = 250;
      submitwidth = 250;
      submitheight = 50;
      padding = 15.0;
      fontsize = 20.0;
    } else {
      containerwidth = 300;
      inputfieldwidth = 3 * width / 8;
      submitwidth = 3 * width / 8;
      submitheight = 50;
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
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: Text(
                              'Enter your github username',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: fontsize,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: CustomInput(
                              Icons.person,
                              "Github username",
                              (value) {
                                if (value.isEmpty) {
                                  return 'Enter your github username';
                                }
                                return null;
                              },
                              false,
                              TextInputType.number,
                              inputfieldwidth,
                              fontsize,
                              _github_username_controller,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
                            child: CustomButton(
                              'Submit',
                              () async {
                                if (_formKey.currentState.validate()) {
                                  String username = _github_username_controller
                                      .text
                                      .toString();
                                  String url =
                                      "https://api.github.com/users/$username";
                                  Response response = await get(url);
                                  int statusCode = response.statusCode;
                                  if (statusCode == 200) {
                                    print("Correct");
                                  } else {
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Spider Orientation"),
                                      content: Text("Invalid github username"),
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
                              submitwidth,
                              submitheight,
                              fontsize,
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
