import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'config.dart';

class Statsdis extends StatelessWidget {
  
  String taskname;
  double adv_percent;
  double beg_percent;

  Statsdis(this.taskname, this.adv_percent, this.beg_percent);

  @override

  Widget build(BuildContext context) {
    return  Column(
              children: <Widget>[
              Text(this.taskname, style: TextStyle( fontSize: 25, fontFamily: config.fontFamily, color: config.fontColor)),
              Text('Adv Task Percentage', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
              CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              percent: (this.adv_percent),
              progressColor: Colors.green,
              animation: true),
               SizedBox(
                height: 10,
              ),
              Text('Beginar Task Percentage', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
              CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              percent: (this.beg_percent),
              progressColor: Colors.red,
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

