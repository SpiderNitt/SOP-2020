import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inductions_20/screens/mentor/mentor_home.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_button.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_input.dart';

// Files imported
import '../../theme/navigation.dart';

class GetDetails extends StatefulWidget {
  @override
  ViewState createState() => ViewState();
}

class ViewState extends State<GetDetails> {
  final _detailsFormKey = GlobalKey<FormState>();
  final _githubUsernameController = TextEditingController();
  double inputfieldwidth;
  double submitwidth;
  double submitheight;
  double padding;
  double fontsize;
  double containerwidth;
  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Container(
                    width: containerwidth,
                    child: Form(
                      key: _detailsFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: Text(
                              'Enter your github username',
                              style: TextStyle(
                                color: theme.fontColor,
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
                              TextInputType.text,
                              inputfieldwidth,
                              fontsize,
                              _githubUsernameController,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
                            child: CustomButton(
                              'Submit',
                              () async {
                                if (_detailsFormKey.currentState.validate()) {
                                  String githubUsername =
                                      _githubUsernameController.text.toString();
                                  String url =
                                      "https://api.github.com/users/$githubUsername";
                                  Response apiResponse = await get(url);
                                  if (apiResponse.statusCode == 200) {
                                    final storage = new FlutterSecureStorage();
                                    String token =
                                        await storage.read(key: "jwt");
                                    final parts = token.split('.');
                                    final payload = parts[1];
                                    var normalized =
                                        base64Url.normalize(payload);
                                    var resp = utf8
                                        .decode(base64Url.decode(normalized));
                                    final payloadMap = json.decode(resp);
                                    String url =
                                        "https://spider.nitt.edu/inductions20test/api/update_github_username";
                                    Map<String, String> headers = {
                                      "Content-type": "application/json",
                                      "Authorization": "Bearer $token"
                                    };
                                    String roll = payloadMap["roll"];
                                    print(roll);
                                    String jsonToken =
                                        '{"rollno" : "$roll", "github_username": "$githubUsername"}';
                                    Response response = await post(url,
                                        headers: headers, body: jsonToken);
                                    if (response.statusCode == 200) {
                                      AlertDialog alert = AlertDialog(
                                        title: Text("Spider Orientation"),
                                        content: Text("Github username saved"),
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
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                      if (payloadMap["is_mentor"]) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Mentor("$token")),
                                        );
                                      } else {
                                        Navigator.pushNamed(
                                            context, '/mentee/');
                                      }
                                    } else {
                                      AlertDialog alert = AlertDialog(
                                        title: Text("Spider Orientation"),
                                        content:
                                            Text("Failed to connect to server"),
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
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    }
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
