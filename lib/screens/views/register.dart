import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inductions_20/screens/ui/base_widget.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Files imported
import 'package:inductions_20/screens/enum/device_screen_type.dart';
import 'package:inductions_20/screens/ui/base_widget.dart';
import 'package:inductions_20/screens/views/widgets/custom_button.dart';
import 'package:inductions_20/screens/views/widgets/custom_input.dart';
import 'package:inductions_20/screens/views/login/responsive_login_view.dart';

final _formKey = GlobalKey<FormState>();
final _key = GlobalKey<FormState>();
final _namecontroller = TextEditingController();
final _usernamecontroller = TextEditingController();
List items = [1, 2, 3, 4, 5, 6, 7];

class RegisterView extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterView> {
  List<bool> _selections = [true, false];
  List _profiles = [
    'Algos',
    'App Development - Android Native',
    'App Development - Flutter',
    'App Development - React Native',
    'Tronix - Embedded Systems and Analog Electronics',
    'Tronix - Robotics and control',
    'Tronix - Signal Processing and Machine Learning',
    'Web Development'
  ];
  List _remprofiles = [
    'None',
    'Algos',
    'App Development - Android Native',
    'App Development - Flutter',
    'App Development - React Native',
    'Tronix - Embedded Systems and Analog Electronics',
    'Tronix - Robotics and control',
    'Tronix - Signal Processing and Machine Learning',
    'Web Development'
  ];
  List _icons = [
    Icons.device_hub,
    Icons.android,
    Icons.android,
    Icons.android,
    Icons.memory,
    Icons.memory,
    Icons.memory,
    Icons.public
  ];
  List _remicons = [
    Icons.do_not_disturb,
    Icons.device_hub,
    Icons.android,
    Icons.android,
    Icons.android,
    Icons.memory,
    Icons.memory,
    Icons.memory,
    Icons.public
  ];
  List<int> _preferences = [1, 0, 0, 0, 0, 0, 0, 0];
  double headingfontsize;
  double formwidth;
  double inputfieldwidth;
  double containerwidth;
  double dropdownwidth;
  double registerwidth;
  double registerheight;
  double padding;
  double fontsize;

  String _dropDownError = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ResponsiveBuild(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        if (sizingInformation.orientation == Orientation.portrait) {
          headingfontsize = 25;
          formwidth = 3 * width / 4;
          inputfieldwidth = 4 * width / 5;
          containerwidth = 4 * width / 5;
          dropdownwidth = 3 * width / 5;
          registerwidth = 6 * width / 7;
          registerheight = width / 8;
          padding = 10.0;
          fontsize = 18.0;
        } else {
          headingfontsize = 25;
          formwidth = width / 2;
          inputfieldwidth = width / 2;
          containerwidth = width / 2;
          dropdownwidth = 3 * width / 8;
          registerwidth = width / 2;
          registerheight = width / 15;
          padding = 10.0;
          fontsize = 18.0;
        }
      } else if (sizingInformation.deviceScreenType ==
          DeviceScreenType.LargeMobile) {
        if (sizingInformation.orientation == Orientation.portrait) {
          headingfontsize = 25;
          formwidth = width / 2;
          inputfieldwidth = width / 2;
          containerwidth = width / 2;
          dropdownwidth = 3 * width / 8;
          registerwidth = width / 2;
          registerheight = width / 15;
          padding = 15.0;
          fontsize = 18.0;
        } else {
          headingfontsize = 25;
          formwidth = width / 2;
          inputfieldwidth = width / 2;
          containerwidth = width / 2;
          dropdownwidth = 3 * width / 8;
          registerwidth = width / 2;
          registerheight = width / 15;
          padding = 15.0;
          fontsize = 18.0;
        }
      } else if (sizingInformation.deviceScreenType ==
          DeviceScreenType.Tablet) {
        if (sizingInformation.orientation == Orientation.portrait) {
          headingfontsize = 30;
          formwidth = width / 2;
          inputfieldwidth = width / 2;
          containerwidth = width / 2;
          dropdownwidth = 3 * width / 8;
          registerwidth = width / 2;
          registerheight = width / 15;
          padding = 20.0;
          fontsize = 25.0;
        } else {
          headingfontsize = 30;
          formwidth = width / 2;
          inputfieldwidth = width / 2;
          containerwidth = width / 2;
          dropdownwidth = 3 * width / 8;
          registerwidth = width / 2;
          registerheight = width / 15;
          padding = 25.0;
        }
      } else {
        if (sizingInformation.orientation == Orientation.portrait) {
          headingfontsize = 40;
          formwidth = width / 2;
          inputfieldwidth = width / 2;
          containerwidth = width / 2;
          dropdownwidth = 3 * width / 8;
          registerwidth = width / 2;
          registerheight = width / 15;
          padding = 25.0;
          fontsize = 30.0;
        } else {
          headingfontsize = 40;
          formwidth = width / 2;
          inputfieldwidth = width / 2;
          containerwidth = width / 2;
          dropdownwidth = 3 * width / 8;
          registerwidth = width / 2;
          registerheight = width / 15;
          padding = 25.0;
          fontsize = 30.0;
        }
      }
      return Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                child: Container(
                  width: formwidth,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Reg',
                        style: TextStyle(
                          color: Color(0xFF00A8E8),
                          fontSize: headingfontsize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        'ister',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: headingfontsize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, padding),
                      child: CustomInput(
                        Icons.person,
                        "Name",
                        (value) {
                          if (value.isEmpty) {
                            return 'Enter Name';
                          }

                          return null;
                        },
                        false,
                        TextInputType.text,
                        inputfieldwidth,
                        18,
                        _namecontroller,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, padding),
                      child: CustomInput(
                        Icons.account_box,
                        "Username",
                        (value) {
                          if (value.isEmpty) {
                            return 'Enter Username';
                          }

                          return null;
                        },
                        false,
                        TextInputType.text,
                        inputfieldwidth,
                        fontsize,
                        _usernamecontroller,
                      ),
                    ),
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, padding),
//                      child: CustomInput(
//                        Icons.details,
//                        "Rollnumber",
//                        (value) {
//                          if (value.isEmpty) {
//                            return 'Enter Rollnumber';
//                          } else if (value.length != 9) {
//                            return 'Enter a valid Rollnumber';
//                          }
//                          return null;
//                        },
//                        false,
//                        TextInputType.number,
//                        inputfieldwidth,
//                        fontsize,
//                        _rollnocontroller,
//                      ),
//                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, padding),
                      child: Text(
                        'Select Profile with Preferences',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: fontsize,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, padding),
                      child: Container(
                        width: containerwidth,
                        decoration: BoxDecoration(
                          color: Color(0xFF00A8E8).withOpacity(0.2),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 8.0, 0.0, 8.0),
                                child: Text(
                                  _dropDownError,
                                  style: TextStyle(
                                    color: Color(0xFF00A8E8),
                                    fontSize: fontsize,
                                  ),
                                ),
                              ),
                              Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Color(0xFF172B34),
                                ),
                                child: DropdownButton<int>(
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: fontsize,
                                  ),
                                  items: _profiles.map((dropDownStringItem) {
                                    var idx =
                                        _profiles.indexOf(dropDownStringItem);
                                    return DropdownMenuItem<int>(
                                      value: idx,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 7.0, 1.0),
                                            child: Icon(_icons[idx],
                                                color: Color(0xFF00A8E8)),
                                          ),
                                          Container(
                                            width: dropdownwidth,
                                            child: Text(
                                              dropDownStringItem,
                                              style: TextStyle(
                                                fontSize: fontsize,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  key: _key,
                                  onChanged: (int newValueSelected) {
                                    setState(() {
                                      _dropDownError = '';
                                      this._preferences[0] =
                                          newValueSelected + 1;
                                      for (int k = 0;
                                          k < this._preferences.length;
                                          k++) {
                                        for (int l = k + 1;
                                            l < this._preferences.length;
                                            l++) {
                                          if (this._preferences[k] ==
                                                  this._preferences[l] &&
                                              this._preferences[k] != 0) {
                                            _dropDownError =
                                                'Enter unique preferences';
                                            break;
                                          }
                                        }
                                        for (int k = 1;
                                            k < this._preferences.length;
                                            k++) {
                                          if (this._preferences[k] != 0) {
                                            for (int l = 1; l < k; l++)
                                              if (this._preferences[l] == 0) {
                                                _dropDownError =
                                                    'Enter previous preferences first';
                                                break;
                                              }
                                          }
                                        }
                                      }
                                    });
                                  },
                                  value: _preferences[0] - 1,
                                ),
                              ),
                              for (int i in items)
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Color(0xFF172B34),
                                  ),
                                  child: DropdownButton<int>(
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: fontsize,
                                    ),
                                    items:
                                        _remprofiles.map((dropDownStringItem) {
                                      var idx = _remprofiles
                                          .indexOf(dropDownStringItem);
                                      return DropdownMenuItem<int>(
                                        value: idx,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 0.0, 7.0, 1.0),
                                              child: Icon(_remicons[idx],
                                                  color: Color(0xFF00A8E8)),
                                            ),
                                            Container(
                                              width: dropdownwidth,
                                              child: Text(
                                                dropDownStringItem,
                                                style: TextStyle(
                                                  fontSize: fontsize,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (int newValueSelected) {
                                      setState(() {
                                        _dropDownError = '';
                                        this._preferences[i] = newValueSelected;
                                        for (int k = 0;
                                            k < this._preferences.length;
                                            k++) {
                                          for (int l = k + 1;
                                              l < this._preferences.length;
                                              l++) {
                                            if (this._preferences[k] ==
                                                    this._preferences[l] &&
                                                this._preferences[k] != 0) {
                                              _dropDownError =
                                                  'Enter unique preferences';
                                              break;
                                            }
                                          }
                                        }
                                        for (int k = 1;
                                            k < this._preferences.length;
                                            k++) {
                                          if (this._preferences[k] != 0) {
                                            for (int l = 1; l < k; l++)
                                              if (this._preferences[l] == 0) {
                                                _dropDownError =
                                                    'Enter previous preferences first';
                                                break;
                                              }
                                          }
                                        }
                                      });
                                    },
                                    value: _preferences[i],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, padding),
                      child: ToggleButtons(
                        borderWidth: 1.5,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        borderColor: Color(0xFF00A8E8),
                        selectedBorderColor: Color(0xFF00A8E8),
                        fillColor: Color(0xFF00A8E8).withOpacity(0.2),
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(padding),
                              child: Text(
                                'Laptop',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: fontsize,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: Text(
                              'No Laptop',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: fontsize,
                              ),
                            ),
                          ),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < _selections.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                _selections[buttonIndex] = true;
                              } else {
                                _selections[buttonIndex] = false;
                              }
                            }
                          });
                        },
                        isSelected: _selections,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, padding),
                      child: CustomButton(
                        'Register',
                        () async {
                          if (_formKey.currentState.validate() &&
                              _dropDownError == '') {
                            // set up POST request arguments
                            String url =
                                "https://spider.nitt.edu/inductions20/register";
                            Map<String, String> headers = {
                              "Content-type": "application/json"
                            };
                            String name = _namecontroller.text;
                            String username = _usernamecontroller.text;
                            bool have_laptop = _selections[0];
                            List<int> preference = [];
                            final storage = new FlutterSecureStorage();
                            //String jwt = await storage.read(key: "jwt");
                            String jwt =
                                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJc01lbnRvciI6ZmFsc2UsIlJvbGxObyI6IjEwNjExODA4OSIsImV4cCI6MTU4NzE2MzIzNH0.UEmrqqFh0UWkZVsin-n7agbw-iUwxxF-ctxLRuFjm00";
                            int k = 0;
                            for (int i = 0; i < _preferences.length; i++) {
                              if (_preferences[i] != 0) {
                                preference.insert(k, _preferences[i]);
                                k++;
                              }
                            }
                            String Json =
                                '{"jwt": "$jwt", "have_laptop": $have_laptop, "username": "$username", "fullname": "$name", "profiles": $preference}';
                            Response response =
                                await post(url, headers: headers, body: Json);
                            print(response.body);
                            int statusCode = response.statusCode;
                            if (statusCode == 403) {
                              AlertDialog alert = AlertDialog(
                                title: Text("Spider Inductions"),
                                content: Text("You've already registered"),
                                actions: [
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
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
                            } else {
                              AlertDialog alert = AlertDialog(
                                title: Text("Spider Inductions"),
                                content:
                                    Text("You have successfully registered"),
                                actions: [
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
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
                        registerwidth,
                        registerheight,
                        20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
