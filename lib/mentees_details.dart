import 'package:flutter/material.dart';
import 'config.dart';

class MenteeDet extends StatelessWidget {

String mentorname;
String mentorgitacc;  

final List <String> name = ['anish', 'jerry', 'Thrishik', 'Bharat', 'joel', 'vishal',  'ashuwin',  'akash',  'sidb'];

MenteeDet(String name, String gitacc){
 this.mentorname = name;
 this.mentorgitacc = gitacc;
}
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 390.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
      itemCount: name.length,
      itemBuilder: (context, index){
        return  Card(
          shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(config.borRadi)),
        elevation: 0.0,
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(config.borRadi),
          border: Border.all(
            width: config.bordWid,
            color: config.bordColor,
          ),
          color: config.conColor,
        ),
        child: ListTile(
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: config.fontColor, ),
          contentPadding: EdgeInsets.all(3),
          onTap: (){
            Navigator.pushNamed(context, '/menteetask', arguments: {
              'name': name[index],
              'git': name[index],
            });
          },
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/android.png'),
          ),
          title: Text('${name[index]}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        ),
        );
      }
    ),
    );
  }
}