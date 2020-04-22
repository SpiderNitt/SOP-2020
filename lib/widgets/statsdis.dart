import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../others/config.dart';

class Statsdis extends StatelessWidget {
  
  String taskname;
  double adv_percent, beg_percent;

  Statsdis(this.taskname, double beg ,double adv){
    this.adv_percent = adv/100;
    this.beg_percent = beg/100;
  }

  @override

  Widget build(BuildContext context) {
    return  Column(
              children: <Widget>[
              Text(this.taskname, style: TextStyle( fontSize: 25, fontFamily: config.fontFamily, color: config.fontColor)),
                 SizedBox(
                height: 10,
              ),
              Text('Adv Task Percentage', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
              CircularPercentIndicator(
              radius: 100.0,
              center: Text('${this.adv_percent*100}%', style: TextStyle( fontSize: 10, fontFamily: config.fontFamily, color: config.fontColor)),
              lineWidth: 10.0,
              percent: (this.adv_percent),
              progressColor: Colors.red,
              animation: true),
               SizedBox(
                height: 10,
              ),
              Text('Beginar Task Percentage', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
              CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              center: Text('${this.beg_percent*100}%', style: TextStyle( fontSize: 10, fontFamily: config.fontFamily, color: config.fontColor)),
              percent: (this.beg_percent),
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

