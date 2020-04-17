import 'package:flutter/material.dart';
import 'config.dart';

class MenteeDet extends StatelessWidget {

String mentorname, mentorgitacc;  

final List <String> name = ['anish', 'jerry', 'Thrishik', 'Bharat', 'joel', 'vishal',  'ashuwin',  'akash',  'sidb'];

MenteeDet(this.mentorname, this.mentorgitacc);

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
        return Column(
          children: <Widget>[
            ListTile(
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
        Divider(
          color: config.fontColor,
          indent: 70,
        ),
        ],
        );
      }
    ),
    );
  }
}