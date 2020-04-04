import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Commits extends StatefulWidget {


  String repo_det;
  
  Commits(String value){
  this.repo_det= value;
  }

  @override
  _CommitsState createState() => _CommitsState(this.repo_det);
}

class _CommitsState extends State<Commits> {

  String repo_det;
  dynamic res;

  _CommitsState(String value){
  this.repo_det = value;
  }

  Future<String> getdata() async{
  Response resp = await get('https://api.github.com/repos/chakki1234/$repo_det/commits');
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
      height: 400,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
      itemCount: this.res.length,
      itemBuilder: (context, index){
        return  Card(
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(config.borRadi),
          border: Border.all(
            width: config.bordWid,
            color: config.bordColor,
          ),
          color: config.conColor,
        ),
          child: ListTile(
          contentPadding: EdgeInsets.all(3),
          title: Text('${res[index]['commit']['message']}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          subtitle: Text('${res[index]['commit']['committer']['date']}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        ),
        );
      }
    ),
    );
  }
}