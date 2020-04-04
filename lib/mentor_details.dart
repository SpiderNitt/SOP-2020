import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MenDet extends StatefulWidget {

String image;
String name;
String gitacc;
 
  MenDet(String name, String gitacc){
    this.name = name;
    this.gitacc = gitacc;
  }

  @override
  _MenDetState createState() => _MenDetState(this.name, this.gitacc);
}

class _MenDetState extends State<MenDet> {

String name;
String gitacc;
dynamic res;
 
  _MenDetState(String name, String gitacc){
    this.name = name;
    this.gitacc = gitacc;
  }
  
  Future<String> getdata() async{
  Response resp = await get('https://api.github.com/users/chakki1234/repos');
  setState(() {
     this.res = jsonDecode(resp.body);
  });
    return 'success';
  }
  
  @override
  
  void initState(){
  super.initState();
  getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: config.conColor,
        border: Border.all(
          color: config.bordColor,
          width: config.bordWid,
        ),
        borderRadius: BorderRadius.circular(config.borRadi),
      ),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Center(
        child: Column(
        children: <Widget>[
         Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: config.bordColor,
            width: config.imgBordrWid,
          ),
        ),
        child: CircleAvatar(
        backgroundImage: NetworkImage('${this.res[0]['owner']['avatar_url']}'),
        radius: 60.0,
        ),
        ),
        SizedBox(height: 8),
        Text('${this.name}', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
        Text('${this.res[0]['owner']['login']}', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
       ], 
      ),
      ),
    );
  }
}