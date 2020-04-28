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
        StatelessWidget,
        Text,
        TextStyle,
        Widget;
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

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
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 370,
            child: Material(
              color: theme.blackColor,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Mentor Assigned",
                      style: TextStyle(
                          color: theme.tertiaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomBox('Contact $mentorName ', () {}, 150, 50, 20,
                            theme.blackColor, 0, 0, 0),
                        if (mentorContact.length <= 15)
                          CustomBox('$mentorContact', () {
                            launch("tel://$mentorContact");
                          }, 110, 50, 12, theme.blackColor, 0, 0, 0),
                        if (mentorContact.length > 10)
                          CustomBox("$mentorContact", () {
                            launch("$mentorContact");
                          }, 200, 50, 12, theme.blackColor, 10, 10, 0),
                      ],
                    ),
                  )
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
                  Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Linkify(
                        onOpen: (link) async {
                          if (await canLaunch(link.url)) {
                            await launch(link.url);
                          } else {
                            throw 'Could not launch $link';
                          }
                        },
                        text: taskDescription,
                        style: TextStyle(fontSize: 17, color: theme.fontColor),
                        linkStyle: TextStyle(color: theme.tertiaryColor),
                      )),
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
          ),
        ),
      ],
    );
  }
}
