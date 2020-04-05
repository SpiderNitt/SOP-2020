import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data {

List<String> repos;

Data(List<String> repoList): this.repos = repoList;

factory Data.getdata(List json){
    List<String> repoDetList = [];
    json.forEach((element){
      repoDetList.add(element['name']);
    });
    print(repoDetList);
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
  // print('//////////////////////////////');
  //  print('//////////////////////////////');
  // print(Data.getdata(jsonDecode(resp.body)).repos);
  //  print('//////////////////////////////');
  //   print('//////////////////////////////');
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

      if(snapshot.hasData){
      

      // print('/////////////////////');
      // print(snapshot.data.repos);
      // print('/////////////////////');

      return Container(
      height: 400,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
      itemCount: snapshot.data.repos.length,
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
              'repo_det': snapshot.data.repos[index],
              // 'git_acc': this.gitacc,
              // 'menteename': this.menteename
            });
          },
          title: Text(snapshot.data.repos[index],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        ),
        );
      }
    ),
    );  
    }
        
      else if (snapshot.hasError){

      print('/////////////////////');
      print('error');
      print('/////////////////////');
      return Text("${snapshot.error}");
      }
        
      else return CircularProgressIndicator();

    });
  }
}