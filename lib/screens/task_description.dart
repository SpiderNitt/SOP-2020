
import 'package:flutter/material.dart';

class Task_description extends StatelessWidget{

final primary;

Task_description(this.primary);

Widget build(BuildContext context) {

return ListView(
    
  children:<Widget>[
      
    Padding(padding: const EdgeInsets.all(16.0),
    child: Container(
    height: 600, 
    width: 370, 
    child: Material(
           color: Color(primary),
           elevation: 10.0,
           borderRadius: BorderRadius.circular(10.0),
           child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text("Description:", style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.white
                        ))],
   ),), )),
   Padding(padding: const EdgeInsets.all(16.0),
   child: Container(
   height: 200, 
   width: 370, 
   child: Material(
          color: Color(primary),
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                      Text(' Resources:', style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.white
                             )) ],
    ),), )),
  ]);
}

}