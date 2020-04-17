import 'dart:html';
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
import 'package:inductions_20/screens/views/success_message.dart';

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
  double dropdownheight = 60;

  String _dropDownError = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ResponsiveBuild(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        if (sizingInformation.orientation == Orientation.portrait) {
          headingfontsize = 22;
          formwidth = 290;
          inputfieldwidth = 290;
          containerwidth = 290;
          dropdownwidth = 230;
          registerwidth = 260;
          registerheight = 40;
          padding = 5.0;
          fontsize = 18.0;
          dropdownheight = 80;
        } else {
          headingfontsize = 22;
          formwidth = 290;
          inputfieldwidth = 290;
          containerwidth = 290;
          dropdownwidth = 230;
          registerwidth = 260;
          registerheight = 40;
          padding = 5.0;
          fontsize = 18.0;
          dropdownheight = 100;
        }
      } else if (sizingInformation.deviceScreenType ==
          DeviceScreenType.LargeMobile) {
        if (sizingInformation.orientation == Orientation.portrait) {
          headingfontsize = 25;
          formwidth = 350;
          inputfieldwidth = 350;
          containerwidth = 350;
          dropdownwidth = 250;
          registerwidth = 350;
          registerheight = 30;
          padding = 15.0;
          fontsize = 18.0;
        } else {
          headingfontsize = 25;
          formwidth = 350;
          inputfieldwidth = 350;
          containerwidth = 350;
          dropdownwidth = 250;
          registerwidth = 350;
          registerheight = 30;
          padding = 15.0;
          fontsize = 18.0;
        }
      } else if (sizingInformation.deviceScreenType ==
          DeviceScreenType.Tablet) {
        if (sizingInformation.orientation == Orientation.portrait) {
          headingfontsize = 25;
          formwidth = 550;
          inputfieldwidth = 500;
          containerwidth = 500;
          dropdownwidth = 400;
          registerwidth = 500;
          registerheight = 60;
          padding = 15.0;
          fontsize = 20.0;
        } else {
          headingfontsize = 25;
          formwidth = 550;
          inputfieldwidth = 500;
          containerwidth = 500;
          dropdownwidth = 400;
          registerwidth = 500;
          registerheight = 60;
          padding = 15.0;
          fontsize = 20.0;
        }
      } else {
        if (sizingInformation.orientation == Orientation.portrait) {
          headingfontsize = 25;
          formwidth = 600;
          inputfieldwidth = 600;
          containerwidth = 600;
          dropdownwidth = 500;
          registerwidth = 600;
          registerheight = 60;
          padding = 15.0;
          fontsize = 20.0;
        } else {
          headingfontsize = 25;
          formwidth = 600;
          inputfieldwidth = 600;
          containerwidth = 600;
          dropdownwidth = 500;
          registerwidth = 600;
          registerheight = 60;
          padding = 15.0;
          fontsize = 20.0;
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
                  width: inputfieldwidth,
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
                      padding: EdgeInsets.all(padding),
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
                        fontsize,
                        _namecontroller,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding),
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
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Text(
                        'Select Profile with Preferences',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: fontsize,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding),
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
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Container(
                                    height: dropdownheight,
                                    child: DropdownButton<int>(
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: fontsize,
                                      ),
                                      items:
                                          _profiles.map((dropDownStringItem) {
                                        var idx = _profiles
                                            .indexOf(dropDownStringItem);
                                        return DropdownMenuItem<int>(
                                          value: idx,
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
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
                                                  if (this._preferences[l] ==
                                                      0) {
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
                                ),
                              ),
                              for (int i in items)
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Color(0xFF172B34),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Container(
                                      height: dropdownheight,
                                      child: DropdownButton<int>(
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: fontsize,
                                        ),
                                        items: _remprofiles
                                            .map((dropDownStringItem) {
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
                                            this._preferences[i] =
                                                newValueSelected;
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
                                                  if (this._preferences[l] ==
                                                      0) {
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
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.all(padding),
                                child: Text(
                                  'NOTE: Selected profiles will be taken in order of preference from top to bottom',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 17,
                                  ),
                                ),
                              )
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
                              "Content-type": "application/json",
                            };
                            String name = _namecontroller.text;
                            String username = _usernamecontroller.text;
                            bool have_laptop = _selections[0];
                            List<int> preference = [];
//                            final storage = new FlutterSecureStorage();
                            String jwt = window.localStorage["jwt"];
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
                            int statusCode = response.statusCode;
                            if (statusCode == 403) {
                              AlertDialog alert = AlertDialog(
                                title: Text("Spider Orientation"),
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
                              final Storage _localStorage = window.localStorage;
                              _localStorage['registered'] = "true";
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MaterialApp(
                                    home: Scaffold(
                                      body: Container(
                                        child: Message(),
                                        decoration: BoxDecoration(
                                          gradient: RadialGradient(
                                            colors: <Color>[
                                              Color(0xFF003459),
                                              Color(0xFF00171f),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
