import 'package:flutter/material.dart';
import 'package:inductions_20/statsdis.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data{
  
  List<String> menteenames;
  
  Data(this.menteenames);
 
  factory Data.model(List res) {
    
    List<String> temp = [];
     res.forEach((element) {
       temp.add(element['title']);
     });
    return Data(temp);
  }

}


class Stats extends StatefulWidget {
 
 String menteename, gitacc, jwt;
 dynamic menteeroll;
 Stats(this.menteename, this.gitacc, this.jwt, this.menteeroll);

  @override
  _StatsState createState() => _StatsState(this.menteename, this.gitacc, this.jwt, this.menteeroll);
}

class _StatsState extends State<Stats> {

  String menteename, gitacc, jwt;
  dynamic menteeroll, res;

  
  Future<Data>  getdata() async{
   Response resp = await get('https://jsonplaceholder.typicode.com/posts');
   return Data.model(jsonDecode(resp.body));
}
   @override
  void initState(){
  super.initState();
  this.res = getdata();
  }

  _StatsState(this.menteename, this.gitacc, this.jwt, this.menteeroll);

  @override

  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: this.res,
      builder: (context, snapshot){
          
          if(snapshot.hasData){
          return Container(
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 390.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
        itemCount: snapshot.data.menteenames.length,
      itemBuilder: (context, index){
        return Statsdis(snapshot.data.menteenames[index], 0.6, 0.2) ;
      }
    ),
    );
    }

      else if (snapshot.hasError)
      return Text("${snapshot.error}", style: TextStyle(color: config.fontColor),);
         
      else return CircularProgressIndicator();

      });
  }
}

