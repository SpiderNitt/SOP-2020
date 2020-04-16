import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data {

List<String> repos;

Data(this.repos);

factory Data.getdata(List json){
    List<String> repoDetList = [];
    json.forEach((element){
      repoDetList.add(element['name']);
    });
    return Data(repoDetList);
  }
}

class RepoDet extends StatefulWidget {
 
  String gitacc;
  String menteename;
  
  RepoDet(this.gitacc, this.menteename);

  @override
  _RepoDetState createState() => _RepoDetState(this.gitacc, this.menteename);
}

class _RepoDetState extends State<RepoDet> {

  String gitacc;
  String menteename;
  dynamic res;

  _RepoDetState(this.gitacc, this.menteename);

  Future<Data> getdata() async{
  Response resp = await get('https://api.github.com/users/chakki1234/repos');
  return Data.getdata(jsonDecode(resp.body));
  }
  

  @override
  void initState(){
  super.initState();
  this.res = getdata();
  }

  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder(
      future: this.res, 
      builder: (context, snapshot){

      if(snapshot.hasData)

      return Container(
      
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 400.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
      itemCount: (snapshot.data.repos.length + 1),
      itemBuilder: (context, index){
        
        if(snapshot.data.repos.length == 0)
         return  Text('No commits yet', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor));
       
        if(index == snapshot.data.repos.length)
          return null; 

         else return Column(
          children: <Widget>[
            ListTile(
            trailing: Icon(
            Icons.keyboard_arrow_right,
            color: config.fontColor, ),
          contentPadding: EdgeInsets.all(3),
          onTap: (){
            Navigator.pushNamed(context, '/commits', arguments: {
              'repo_det': snapshot.data.repos[index],
              'git_acc': this.gitacc,
              'menteename': this.menteename
            });
          },
          title: Text(snapshot.data.repos[index],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        Divider(
          color: config.fontColor,
        )
          ],
        );
      }
    ),
    );  

      else if (snapshot.hasError)
      return Text("${snapshot.error}", style: TextStyle(color: config.fontColor),);
         
      else return CircularProgressIndicator();

    });
  }
}