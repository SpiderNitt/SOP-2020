import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class RepoDet extends StatefulWidget {
 
  String gitacc;
  String menteename;
  
  RepoDet(String gitacc, String menteename){
  this.gitacc = gitacc;
  this.menteename = menteename;
  }

  @override
  _RepoDetState createState() => _RepoDetState(this.gitacc, this.menteename);
}

class _RepoDetState extends State<RepoDet> {

  String gitacc;
  String menteename;
  dynamic res;

  _RepoDetState(String gitacc, String menteename){
  this.gitacc = gitacc;
  this.menteename = menteename;
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
          onTap: (){
            Navigator.pushNamed(context, '/commits', arguments: {
              'repo_det': this.res[index]['name'],
              'git_acc': this.gitacc,
              'menteename': this.menteename
            });
          },
          title: Text('${res[index]['name']}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        ),
        );
      }
    ),
    );
  }
}