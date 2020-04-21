import 'package:flutter/material.dart';
import 'custom_box.dart';
import 'package:inductions_20/Themes/styling.dart';


class Announcementbox extends StatelessWidget{

final username;
final date;
final time;
final String text;
final double _width;

Announcementbox(this.username, this.date, this.time, this.text, this._width);


Widget build(BuildContext context) {
  return 
  
              Padding(
              padding: EdgeInsets.all(10),
              child:Container(
              width: _width,
              
              color: theme.blackColor,
              child: Padding(
                   padding: EdgeInsets.all(15),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    children: <Widget>[
                      CircleAvatar(child: Text("A"),),
                      Custom_box('''${username}''',(){},100,50,16,theme.blackColor,15,0,0),
                      Custom_box('''${date} ${time}''',(){},130,60,10,theme.blackColor,18,0,0)
                   ]
                  ),
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: Container(
                    child: Text('''${text}''', 
                         style: TextStyle(fontSize: 15, color:theme.fontColor),
                  ),

                 ))
                ],
              )),
              ));



}

}