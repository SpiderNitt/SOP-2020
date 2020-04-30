import 'package:flutter/material.dart';
import '../../../theme/mentor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Statsdis extends StatelessWidget {
  final String taskname, profile;
  final double beg, adv;
  Statsdis(this.taskname, this.beg, this.adv, this.profile);

  @override
  Widget build(BuildContext context) {
    var begPercent = beg / 100;
    var advPercent = adv / 100;

    return Column(
      children: <Widget>[
        Text('${this.profile}',
            style: TextStyle(
                fontSize: 25,
                fontFamily: config.fontFamily,
                color: config.head)),
        SizedBox(
          height: 10,
        ),
        Text('${this.taskname}',
            style: TextStyle(
                fontSize: 22,
                fontFamily: config.fontFamily,
                color: config.fontColor)),
        SizedBox(
          height: 10,
        ),
        Text('Adv Task Percentage',
            style: TextStyle(
                fontSize: 20,
                fontFamily: config.fontFamily,
                color: config.fontColor)),
        CircularPercentIndicator(
            radius: 100.0,
            center: Text('${advPercent * 100}%',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: config.fontFamily,
                    color: config.fontColor)),
            lineWidth: 10.0,
            percent: (advPercent),
            progressColor: Colors.red,
            animation: true),
        SizedBox(
          height: 10,
        ),
        Text('Basic Task Percentage',
            style: TextStyle(
                fontSize: 20,
                fontFamily: config.fontFamily,
                color: config.fontColor)),
        CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            center: Text('${begPercent * 100}%',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: config.fontFamily,
                    color: config.fontColor)),
            percent: (begPercent),
            progressColor: Colors.green,
            animation: true),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: config.fontColor,
        )
      ],
    );
  }
}
