import 'package:flutter/material.dart';
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inductions_20/screens/mentee/data/task_description.dart';

class Task_description extends StatelessWidget {
  final primary;

  List resource_desc;
  List resource_link;
  var task_description;
  var mentor_name;
  var mentor_contact;

  Task_description(this.primary, this.task_description, this.resource_link,
      this.resource_desc, this.mentor_name, this.mentor_contact);
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
                              Custom_box('Contact $mentor_name ', () {}, 150,
                                  50, 14, theme.blackColor, 0, 0, 0),
                              Custom_box('($mentor_contact)', () {
                                launch("tel://$mentor_contact");
                              }, 95, 50, 14, theme.blackColor, 0, 0, 0),
                            ]))
                      ])))),
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
                  Text('''$task_description''',
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
                      child: Text(' Resources:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: theme.tertiaryColor))),
                  for (int i = 0; i < resource_link.length; i++)
                    Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(''' ${resource_desc[i]} ''',
                                  style: TextStyle(
                                      fontSize: 17, color: theme.fontColor)),
                              Custom_box('''${resource_link[i]}''', () {
                                launch('${resource_link[i]}');
                              }, 370, 38, 15, primary, 0, 0, 0),
                            ]))
                ],
              ),
            ),
          )),
    ]);
  }
}
