import 'package:flutter/material.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data {
  String gitacc, avatar_url;

  Data({this.gitacc, this.avatar_url});

  factory Data.fromJson(List json) {
    return Data(
      gitacc: json[0]['owner']['login'],
      avatar_url: json[0]['owner']['avatar_url']
    );
  }
}


class MenDet extends StatefulWidget {

String name, gitacc;
 
MenDet(this.name, this.gitacc);

  @override
  _MenDetState createState() => _MenDetState(this.name, this.gitacc);
}

class _MenDetState extends State<MenDet> {

String name, gitacc;
dynamic res;
 
_MenDetState(this.name, this.gitacc);
  
  Future<Data> getdata() async{
  Response resp = await get('https://api.github.com/users/chakki1234/repos');
  return Data.fromJson(json.decode(resp.body));
  }
  
  @override
  
  void initState() {
  super.initState();
  this.res = getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: config.conColor,
      //   border: Border.all(
      //     color: config.bordColor,
      //     width: config.bordWid,
      //   ),
      //   borderRadius: BorderRadius.circular(config.borRadi),
      // ),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Center(
        child:  FutureBuilder<Data>(
            future: this.res,
            builder: (context, snapshot){
              
            if(snapshot.hasData)
          
          return   Column(
           children : <Widget>[Container(
          decoration: BoxDecoration(
          shape: BoxShape.circle,
         ),
         child: CircleAvatar(
         backgroundImage: NetworkImage(snapshot.data.avatar_url),
         radius: 60.0,
          ),
           ),
        SizedBox(height: 8),
        Text('${this.name}', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
        Text('${snapshot.data.gitacc}', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
        Divider(
          color: config.fontColor,
          indent: 20,
          endIndent: 20,
        ) 
         ]
          );
       else if (snapshot.hasError) {
       return Text("${snapshot.error}", style: TextStyle( color: config.fontColor ),);
      }
      else
     
      return CircularProgressIndicator();
        }),
      ),
    );
  }
}