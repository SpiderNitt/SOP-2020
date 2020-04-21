import 'package:flutter/material.dart';
import 'statsdis.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data{
  
  List<String> menteenames;
  String status;
  
  Data(this.menteenames);
 
  factory Data.model(List res) {
    
    List<String> temp = [];
     res.forEach((element) {
       temp.add(element['title']);
     });
    return Data(temp);
  }

    Data.for500(){
     this.status = '500';
}
 Data.for403(){
      this.status = '403';
 }

 Data.for401(){
     this.status = '401';
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

   if(resp.headers['status'] == '500')
   return  Data.for500();
  else if(resp.headers['status'] == '403')
   return Data.for403();
  else if(resp.headers['status'] == '401')
   return Data.for401();
  else 
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

           if(snapshot.data.status == '500')
              return Text("Server Error", style: TextStyle( color: config.fontColor ),);
           
          else if (snapshot.data.status == '401')
              return Text("Forbidden not enough rights", style: TextStyle( color: config.fontColor ),);
          
          else if (snapshot.data.status == '403')
           return Text("Unauthorized", style: TextStyle( color: config.fontColor ),);

          else 
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

