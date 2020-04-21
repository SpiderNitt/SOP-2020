import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:inductions_20/theme/styling.dart';

class Message extends StatefulWidget {
  @override
  MessageState createState() => MessageState();
}

class MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
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
            child: Center(
              child: Text(
                'SUCCESSFULLY REGISTERED',
                style: TextStyle(
                  color: theme.fontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                          "TRONIX",
                          "WEB DEV",
                          "APP DEV",
                          "ALGOS",
                        ],
                        textStyle: TextStyle(
                          fontSize: 20,
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
    );
  }
}
