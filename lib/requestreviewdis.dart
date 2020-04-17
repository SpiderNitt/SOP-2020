import 'package:flutter/material.dart';
import 'config.dart';

class Requestlist extends StatelessWidget {

String mentorname;
String mentorgitacc;  

final List <String> name = ['anish', 'jerry', 'Thrishik', 'Bharat', 'joel', 'vishal',  'ashuwin',  'akash',  'sidb'];

Requestlist(this.mentorname, this.mentorgitacc);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: name.length,
      itemBuilder: (context, index){
        return Column(
          children: <Widget>[
            ListTile(
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
          subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   SizedBox(
                    height:5,
                  ),
                  Text('Task1', softWrap: true,  style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.fontColor)),
                  SizedBox(
                    height:5,
                  ),
                  Text('Repo link: http://github.com/chakki/dfgh/dsafgdhf/sdafghj/dfshk/dfshk/dfhjkl/dfshk/dsfhj',  softWrap: true, style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.fontColor)),
                   SizedBox(
                    height:5,
                  ),
                  Text('Not reviewed', softWrap: true, style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.danger)),
                  SizedBox(
                    height:5,
                  ),
                  FlatButton(
                  onPressed: (){
                  Navigator.pushNamed(context, '/writereview', arguments: {
                  'repo_det': 'task1',
                   });
          }, 
         child: Text('Write a review', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
         ),
                ],
              ),
        ),
        Divider(
          color: config.fontColor,
          indent: 70,
        ),
        ],
        );
      }
    );
  }
}