import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

// Files imported
import 'package:inductions_20/screens/views/widgets/custom_button.dart';
import 'package:inductions_20/screens/views/widgets/custom_input.dart';
import 'package:inductions_20/screens/views/widgets/upload_button.dart';
import 'package:inductions_20/screens/views/login/responsive_login_view.dart';

final _formKey = GlobalKey<FormState>();
final _key = GlobalKey<FormState>();
final _namecontroller = TextEditingController();
final _usernamecontroller = TextEditingController();
final _rollnocontroller = TextEditingController();
List items = [1, 2, 3, 4, 5, 6, 7];

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////
Portrait
////////////////////////////////////////////////////////////////////////////////////////////////////////
*/

class Register_Mobile_Portrait extends StatefulWidget {
  @override
  _RegisterPortraitScreenState createState() => _RegisterPortraitScreenState();
}

class _RegisterPortraitScreenState extends State<Register_Mobile_Portrait> {
  List<bool> _selections = [true, false];
  List _profiles = [
    'Algos',
    'App Development - Flutter',
    'App Development - Android Native',
    'App Development - React Native',
    'Tronix - Robotics and control',
    'Tronix - Embedded Systems and Analog Electronics',
    'Tronix - Signal Processing and Machine Learning',
    'Web Development'
  ];
  List _remprofiles = [
    'None',
    'Algos',
    'App Development - Flutter',
    'App Development - Android Native',
    'App Development - React Native',
    'Tronix - Robotics and control',
    'Tronix - Embedded Systems and Analog Electronics',
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

  String _dropDownError = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                width: 3 * width / 4,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Reg',
                      style: TextStyle(
                        color: Color(0xFF00A8E8),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      'ister',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 25.0,
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
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
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
                      6 * width / 7,
                      18,
                      _namecontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
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
                      6 * width / 7,
                      18,
                      _usernamecontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: CustomInput(
                      Icons.details,
                      "Rollnumber",
                      (value) {
                        if (value.isEmpty) {
                          return 'Enter Rollnumber';
                        } else if (value.length != 9) {
                          return 'Enter a valid Rollnumber';
                        }
                        return null;
                      },
                      false,
                      TextInputType.number,
                      6 * width / 7,
                      18,
                      _rollnocontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: Text(
                      'Select Profile with Preferences',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Container(
                      width: 6 * width / 7,
                      decoration: BoxDecoration(
                        color: Color(0xFF00A8E8).withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                              child: Text(
                                _dropDownError,
                                style: TextStyle(
                                  color: Color(0xFF00A8E8),
                                  fontSize: 18.0,
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
                                  fontSize: 20,
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
                                          width: 3 * width / 5,
                                          child: Text(
                                            dropDownStringItem,
                                            style: TextStyle(
                                              fontSize: 18,
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
                                    this._preferences[0] = newValueSelected + 1;
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
                                    fontSize: 20,
                                  ),
                                  items: _remprofiles.map((dropDownStringItem) {
                                    var idx = _remprofiles
                                        .indexOf(dropDownStringItem);
                                    return DropdownMenuItem<int>(
                                      value: idx,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 7.0, 1.0),
                                            child: Icon(_remicons[idx],
                                                color: Color(0xFF00A8E8)),
                                          ),
                                          Container(
                                            width: 3 * width / 5,
                                            child: Text(
                                              dropDownStringItem,
                                              style: TextStyle(
                                                fontSize: 18,
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
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                              child: CustomButton(
                                'Reset',
                                () {
                                  if (_formKey.currentState.validate()) {
                                    // Process data.
                                    _profiles = [
                                      'Algos',
                                      'App Development - Flutter',
                                      'App Development - Android Native',
                                      'App Development - React Native',
                                      'Tronix - Robotics and control',
                                      'Tronix - Embedded Systems and Analog Electronics',
                                      'Tronix - Signal Processing and Machine Learning',
                                      'Web Development'
                                    ];
                                    _remprofiles = [
                                      'None',
                                      'Algos',
                                      'App Development - Flutter',
                                      'App Development - Android Native',
                                      'App Development - React Native',
                                      'Tronix - Robotics and control',
                                      'Tronix - Embedded Systems and Analog Electronics',
                                      'Tronix - Signal Processing and Machine Learning',
                                      'Web Development'
                                    ];
                                  }
                                },
                                3 * width / 4,
                                width / 10,
                                20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Laptop',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No Laptop',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 18,
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
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: CustomButton(
                      'Register',
                      () {
                        if (_formKey.currentState.validate() &&
                            _dropDownError == '') {
                          // Process data.

                        }
                      },
                      3 * width / 4,
                      width / 10,
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
  }
}

/*
//////////////////////////////////////////////////////////////////////////////////////////////////////
Landscape
//////////////////////////////////////////////////////////////////////////////////////////////////////
*/
class Register_Mobile_Landscape extends StatefulWidget {
  @override
  _RegisterLandscapeScreenState createState() =>
      _RegisterLandscapeScreenState();
}

class _RegisterLandscapeScreenState extends State<Register_Mobile_Landscape> {
  List<bool> _selections = [true, false];
  List _profiles = [
    'Algos',
    'App Development - Flutter',
    'App Development - Android Native',
    'App Development - React Native',
    'Tronix - Robotics and control',
    'Tronix - Embedded Systems and Analog Electronics',
    'Tronix - Signal Processing and Machine Learning',
    'Web Development'
  ];
  List _remprofiles = [
    'None',
    'Algos',
    'App Development - Flutter',
    'App Development - Android Native',
    'App Development - React Native',
    'Tronix - Robotics and control',
    'Tronix - Embedded Systems and Analog Electronics',
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
  var _preference1 = 'Web Development';
  var _preference2 = 'None';
  var _preference3 = 'None';
  var _preference4 = 'None';

  String _dropDownError = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                width: width / 2,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Reg',
                      style: TextStyle(
                        color: Color(0xFF00A8E8),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      'ister',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 25.0,
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
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
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
                      width / 2,
                      18,
                      _namecontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
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
                      width / 2,
                      18,
                      _usernamecontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: CustomInput(
                      Icons.details,
                      "Rollnumber",
                      (value) {
                        if (value.isEmpty) {
                          return 'Enter Rollnumber';
                        } else if (value.length != 9) {
                          return 'Enter a valid Rollnumber';
                        }
                        return null;
                      },
                      false,
                      TextInputType.number,
                      width / 2,
                      18,
                      _rollnocontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Container(
                      width: width / 2,
                      decoration: BoxDecoration(
                        color: Color(0xFF00A8E8).withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                              child: Text(
                                'Select Profile with Preferences',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                              child: Text(
                                _dropDownError,
                                style: TextStyle(
                                  color: Color(0xFF00A8E8),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(0xFF172B34),
                              ),
                              child: DropdownButton<String>(
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 20,
                                ),
                                items: _profiles.map((dropDownStringItem) {
                                  var idx =
                                      _profiles.indexOf(dropDownStringItem);
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 7.0, 1.0),
                                          child: Icon(_icons[idx],
                                              color: Color(0xFF00A8E8)),
                                        ),
                                        Container(
                                          width: 3 * width / 8,
                                          child: Text(
                                            dropDownStringItem,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  setState(() {
                                    this._preference1 = newValueSelected;
                                    if (this._preference2 != 'None' &&
                                            this._preference1 ==
                                                this._preference2 ||
                                        this._preference3 != 'None' &&
                                            this._preference1 ==
                                                this._preference3 ||
                                        this._preference4 != 'None' &&
                                            this._preference1 ==
                                                this._preference4 ||
                                        this._preference2 != 'None' &&
                                            this._preference3 != 'None' &&
                                            this._preference2 ==
                                                this._preference3 ||
                                        this._preference2 != 'None' &&
                                            this._preference4 != 'None' &&
                                            this._preference2 ==
                                                this._preference4 ||
                                        this._preference3 != 'None' &&
                                            this._preference4 != 'None' &&
                                            this._preference3 ==
                                                this._preference4) {
                                      this._dropDownError =
                                          'Enter unique preferences';
                                    } else {
                                      this._dropDownError = '';
                                    }
                                  });
                                },
                                value: _preference1,
                              ),
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(0xFF172B34),
                              ),
                              child: DropdownButton<String>(
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 20,
                                ),
                                items: _remprofiles.map((dropDownStringItem) {
                                  var idx =
                                      _remprofiles.indexOf(dropDownStringItem);
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 7.0, 1.0),
                                          child: Icon(_remicons[idx],
                                              color: Color(0xFF00A8E8)),
                                        ),
                                        Container(
                                          width: 3 * width / 8,
                                          child: Text(
                                            dropDownStringItem,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  setState(() {
                                    this._preference2 = newValueSelected;
                                    if (this._preference2 == 'None' &&
                                        (this._preference3 != 'None' ||
                                            this._preference4 != 'None')) {
                                      this._dropDownError =
                                          'Enter preferences in order';
                                    } else if (this._preference1 == 'None') {
                                      this._dropDownError =
                                          'Enter above preferences first';
                                    } else if (this._preference2 != 'None' &&
                                            this._preference1 ==
                                                this._preference2 ||
                                        this._preference3 != 'None' &&
                                            this._preference1 ==
                                                this._preference3 ||
                                        this._preference4 != 'None' &&
                                            this._preference1 ==
                                                this._preference4 ||
                                        this._preference2 != 'None' &&
                                            this._preference3 != 'None' &&
                                            this._preference2 ==
                                                this._preference3 ||
                                        this._preference2 != 'None' &&
                                            this._preference4 != 'None' &&
                                            this._preference2 ==
                                                this._preference4 ||
                                        this._preference3 != 'None' &&
                                            this._preference4 != 'None' &&
                                            this._preference3 ==
                                                this._preference4) {
                                      this._dropDownError =
                                          'Enter unique preferences';
                                    } else {
                                      this._dropDownError = '';
                                    }
                                  });
                                },
                                value: _preference2,
                              ),
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(0xFF172B34),
                              ),
                              child: DropdownButton<String>(
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 20,
                                ),
                                items: _remprofiles.map((dropDownStringItem) {
                                  var idx =
                                      _remprofiles.indexOf(dropDownStringItem);
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 7.0, 1.0),
                                          child: Icon(_remicons[idx],
                                              color: Color(0xFF00A8E8)),
                                        ),
                                        Container(
                                          width: 3 * width / 8,
                                          child: Text(
                                            dropDownStringItem,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  setState(() {
                                    this._preference3 = newValueSelected;
                                    if (this._preference3 == 'None' &&
                                        (this._preference4 != 'None')) {
                                      this._dropDownError =
                                          'Enter preferences in order';
                                    } else if (this._preference1 == 'None' ||
                                        this._preference2 == 'None') {
                                      this._dropDownError =
                                          'Enter above preferences first';
                                    } else if (this._preference2 != 'None' &&
                                            this._preference1 ==
                                                this._preference2 ||
                                        this._preference3 != 'None' &&
                                            this._preference1 ==
                                                this._preference3 ||
                                        this._preference4 != 'None' &&
                                            this._preference1 ==
                                                this._preference4 ||
                                        this._preference2 != 'None' &&
                                            this._preference3 != 'None' &&
                                            this._preference2 ==
                                                this._preference3 ||
                                        this._preference2 != 'None' &&
                                            this._preference4 != 'None' &&
                                            this._preference2 ==
                                                this._preference4 ||
                                        this._preference3 != 'None' &&
                                            this._preference4 != 'None' &&
                                            this._preference3 ==
                                                this._preference4) {
                                      this._dropDownError =
                                          'Enter unique preferences';
                                    } else {
                                      this._dropDownError = '';
                                    }
                                  });
                                },
                                value: _preference3,
                              ),
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(0xFF172B34),
                              ),
                              child: DropdownButton<String>(
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 20,
                                ),
                                items: _remprofiles.map((dropDownStringItem) {
                                  var idx =
                                      _remprofiles.indexOf(dropDownStringItem);
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 7.0, 1.0),
                                          child: Icon(_remicons[idx],
                                              color: Color(0xFF00A8E8)),
                                        ),
                                        Container(
                                          width: 3 * width / 8,
                                          child: Text(
                                            dropDownStringItem,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  setState(() {
                                    this._preference4 = newValueSelected;
                                    if (this._preference1 == 'None' ||
                                        this._preference2 == 'None' ||
                                        this._preference3 == 'None') {
                                      this._dropDownError =
                                          'Enter above preferences first';
                                    } else if ((this._preference2 != 'None' &&
                                            this._preference1 ==
                                                this._preference2) ||
                                        (this._preference3 != 'None' &&
                                            this._preference1 ==
                                                this._preference3) ||
                                        (this._preference4 != 'None' &&
                                            this._preference1 ==
                                                this._preference4) ||
                                        (this._preference2 != 'None' &&
                                            this._preference3 != 'None' &&
                                            this._preference2 ==
                                                this._preference3) ||
                                        (this._preference2 != 'None' &&
                                            this._preference4 != 'None' &&
                                            this._preference2 ==
                                                this._preference4) ||
                                        (this._preference3 != 'None' &&
                                            this._preference4 != 'None' &&
                                            this._preference3 ==
                                                this._preference4)) {
                                      this._dropDownError =
                                          'Enter unique preferences';
                                    } else {
                                      this._dropDownError = '';
                                    }
                                  });
                                },
                                value: _preference4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Laptop',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No Laptop',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 18,
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
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: CustomButton(
                      'Register',
                      () {
                        if (_formKey.currentState.validate() &&
                            _dropDownError == '') {
                          // Process data.

                        }
                      },
                      3 * width / 8,
                      width / 15,
                      18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
