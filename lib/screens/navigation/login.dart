import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:inductions_20/screens/mentor/mentor_home.dart';
import 'package:inductions_20/screens/navigation/get_details.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_button.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_input.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Files imported
import '../../theme/navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginScreen> {
  var subscription;

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
  StreamSubscription<ConnectivityResult> initState() {
    super.initState();
    return subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        AlertDialog alert = AlertDialog(
          title: Text("Spider Orientation"),
          content:
              Text("No internet connection. Reconnect and reopen the app."),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop('dialog');
                SystemNavigator.pop();
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
    });
  }

  dispose() {
    super.dispose();
    subscription.cancel();
  }

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
                    child: Form(
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
                            padding:
                                EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
                            child: CustomButton(
                              'Sign In',
                              () async {
                                if (_loginFormKey.currentState.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                        body: Container(
                                          decoration: BoxDecoration(
                                            gradient: RadialGradient(
                                              colors: <Color>[
                                                theme.secondaryColor,
                                                theme.primaryColor,
                                              ],
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Image(
                                                image: AssetImage(
                                                  'assets/images/spiderIcon.png',
                                                ),
                                                height: imagesize * 0.7,
                                                width: imagesize * 0.7,
                                              ),
                                              Center(
                                                child: SpinKitPouringHourglass(
                                                  color: Colors.white,
                                                  size: 70.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  String url =
                                      "https://spider.nitt.edu/inductions20test/login/";
                                  Map<String, String> headers = {
                                    "Content-type": "application/json",
                                  };
                                  String rollno =
                                      _rollnocontroller.text.toString();
                                  String password = _passwordcontroller.text;
                                  String jsonToken =
                                      '{"rollno": "$rollno", "password": "$password"}';
                                  Response response = await post(url,
                                      headers: headers, body: jsonToken);
                                  // int statusCode = response.statusCode;
                                  var parsedJson =
                                      await json.decode(response.body);
                                  print(response.body);
                                  if (parsedJson["success"] == true) {
                                    final String jwt = parsedJson["jwt"];
                                    final storage = new FlutterSecureStorage();
                                    await storage.write(
                                        key: "jwt", value: "$jwt");
                                    await storage.write(
                                        key: "password", value: "$password");
                                    String token =
                                        await storage.read(key: "jwt");
                                    final parts = token.split('.');
                                    final payload = parts[1];
                                    var normalized =
                                        base64Url.normalize(payload);
                                    var resp = utf8
                                        .decode(base64Url.decode(normalized));
                                    final payloadMap = json.decode(resp);
                                    Navigator.pop(context);
                                    if (parsedJson["is_first_time"] == true) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GetDetails("$password")));
                                    } else {
                                      if (payloadMap["is_mentor"]) {
                                        print("Login as mentor");
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mentor("$token")),
                                                ModalRoute.withName('/mentor'));
                                      } else {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/mentee/',
                                                (Route<dynamic> route) =>
                                                    false);
                                      }
                                    }
                                  } else {
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Spider Orientation"),
                                      content: Text(
                                          "Incorrect roll number and password"),
                                      actions: [
                                        FlatButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.pop(context);
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
