import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../others/config.dart';

class Statsdis extends StatelessWidget {
  final String taskname;
  double advPercent, begPercent;

  Statsdis(this.taskname, double beg, double adv) {
    this.advPercent = adv / 100;
    this.begPercent = beg / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(this.taskname,
            style: TextStyle(
                fontSize: 25,
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
            center: Text('${this.advPercent * 100}%',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: config.fontFamily,
                    color: config.fontColor)),
            lineWidth: 10.0,
            percent: (this.advPercent),
            progressColor: Colors.red,
            animation: true),
        SizedBox(
          height: 10,
        ),
        Text('Beginar Task Percentage',
            style: TextStyle(
                fontSize: 20,
                fontFamily: config.fontFamily,
                color: config.fontColor)),
        CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            center: Text('${this.begPercent * 100}%',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: config.fontFamily,
                    color: config.fontColor)),
            percent: (this.begPercent),
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
