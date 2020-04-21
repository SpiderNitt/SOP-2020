import 'package:flutter/material.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data {

List<String> repos;
String status, errormsg;

Data(this.repos, this.status);

factory Data.getdata(List json){
    List<String> repoDetList = [];
    json.forEach((element){
      repoDetList.add(element['name']);
    });
    return Data(repoDetList, '200 OK');
  }

Data.error(this.errormsg, this.status);

}

class RepoDet extends StatefulWidget {
 
  String gitacc, menteename, jwt;
  
  RepoDet(this.gitacc, this.menteename, this.jwt);

  @override
  _RepoDetState createState() => _RepoDetState(this.gitacc, this.menteename, this.jwt);
}

class _RepoDetState extends State<RepoDet> {

  String gitacc, menteename ,jwt;
  dynamic res;

  _RepoDetState(this.gitacc, this.menteename, this.jwt);

  Future<Data> getdata() async{
  Response resp = await get('https://api.github.com/users/chakki1234/repos');
 
  if(resp.headers['status'] == '200 OK')
  return Data.getdata(jsonDecode(resp.body));
  else 
  return Data.error(resp.headers['status'], json.decode(resp.body)['message']);
 
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

      if(snapshot.hasData){
      
     if(snapshot.data.status == '200 OK')
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
         return  Text('No repos yet', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor));
       
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
              'menteename': this.menteename,
              'jwt': this.jwt
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
             
      else 
       return Text("${snapshot.data.errormsg}", style: TextStyle( color: config.fontColor ),);
      }
        else if(snapshot.hasError){
        return Text("${snapshot.error}", style: TextStyle( color: config.fontColor ),);
      }

      else return CircularProgressIndicator();

    });
  }
}