import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        FontWeight,
        ListView,
        MainAxisAlignment,
        Material,
        Padding,
        Row,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_box.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDescription extends StatelessWidget {
  final primary;

  final List resourceDesc;
  final List resourceLink;
  final dynamic taskDescription;
  final dynamic mentorName;
  final dynamic mentorContact;

  TaskDescription(this.primary, this.taskDescription, this.resourceLink,
      this.resourceDesc, this.mentorName, this.mentorContact);
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 370,
          child: Material(
            color: theme.blackColor,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Mentor Assigned",
                      style: TextStyle(
                          color: theme.tertiaryColor,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(children: <Widget>[
                      CustomBox('Contact $mentorName ', () {}, 150, 50, 14,
                          theme.blackColor, 0, 0, 0),
                      CustomBox('($mentorContact)', () {
                        launch("tel://$mentorContact");
                      }, 110, 50, 14, theme.blackColor, 0, 0, 0),
                    ]))
              ],
            ),
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 370,
            child: Material(
              color: primary,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Description:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.tertiaryColor,
                      )),
                  Text('''$taskDescription''',
                      style: TextStyle(fontSize: 17, color: theme.fontColor))
                ],
              ),
            ),
          )),
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 370,
            child: Material(
              color: primary,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text(
                      ' Resources:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.tertiaryColor),
                    ),
                  ),
                  for (int i = 0; i < resourceLink.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(''' ${resourceDesc[i]} ''',
                              style: TextStyle(
                                  fontSize: 17, color: theme.fontColor)),
                          CustomBox('''${resourceLink[i]}''', () {
                            launch('${resourceLink[i]}');
                          }, 370, 38, 15, primary, 0, 0, 0),
                        ],
                      ),
                    )
                ],
              ),
            ),
          )),
    ]);
  }
}
