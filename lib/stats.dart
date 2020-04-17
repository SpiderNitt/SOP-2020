import 'package:flutter/material.dart';
import 'package:inductions_20/statsdis.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  
  List tsk_names = ['Task1', 'Task2', 'Task3'];
  
  @override

  Widget build(BuildContext context) {
    return  Container(
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 390.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
        itemCount: this.tsk_names.length,
      itemBuilder: (context, index){
        return Statsdis(tsk_names[index], 0.6, 0.2) ;
      }
    ),
    );
  }
}