import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inductions_20/others/jwtparse.dart';
import 'package:inductions_20/screens/mentor/mentor_home.dart';
import 'dart:async';

// Files imported
import '../../theme/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // todo: implement initState
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () async {
        dynamic storage = new FlutterSecureStorage();
        var jwtToken = await storage.read(key: "jwt");
        print(jwtToken);
        if (jwtToken == null)
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        else {
          var res = tryParseJwt(jwtToken);
          if (res["is_mentor"]) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Mentor(jwtToken)),
            );
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/mentee/', (Route<dynamic> route) => false);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image(
                image: AssetImage(
                  'assets/images/SpiderLogo.webp',
                ),
                height: 200,
                width: 200,
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 300,
                      child: TypewriterAnimatedTextKit(
                          onTap: () {
                            print("Tap Event");
                          },
                          text: [
                            "ALGOS",
                            "APP DEV",
                            "TRONIX",
                            "WEB DEV",
                          ],
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: "Agne",
                            color: theme.fontColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          alignment: AlignmentDirectional
                              .topStart // or Alignment.topLeft
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.memory,
                              size: height / 25,
                              color: theme.tertiaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.public,
                              size: height / 25,
                              color: theme.tertiaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.android,
                              size: height / 25,
                              color: theme.tertiaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.device_hub,
                              size: height / 25,
                              color: theme.tertiaryColor,
                            ),
                          )
                        ],
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