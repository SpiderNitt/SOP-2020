import 'dart:io';
import 'package:flutter/material.dart';
import 'statsdis.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../others/jwtparse.dart';

class Data{
  
  List<Map> submission;
  String status;
  
  Data(this.submission);
 
  factory Data.model(dynamic res) {
    
    List<Map> temp = [];
    for(int i = 0; i < res['submissions'].length; ++i){
      temp.add({
           'title': res['submissions']['$i']['task_title'],
           'basic': (res['submissions']['$i']['basic_task_status'])? '100.0' : '0.0',
           'adv': '${res['submissions']['$i']['advanced_task_percent']}'
      });
    }
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
 
 String menteename, gitacc, jwt, menteeroll;

 Stats(this.menteename, this.gitacc, this.jwt, this.menteeroll);

  @override
  _StatsState createState() => _StatsState(this.menteename, this.gitacc, this.jwt, this.menteeroll);
}

class _StatsState extends State<Stats> {

  String menteename, gitacc, jwt, menteeroll, mentorroll;
  dynamic  res;

    _StatsState(this.menteename, this.gitacc, this.jwt, this.menteeroll){
     this.mentorroll = tryParseJwt(this.jwt)['roll'];
  }
  
  Future<Data>  getdata() async{

    Response resp = await get('https://spider.nitt.edu/inductions20test/api/mentor/${this.mentorroll}/submission/${this.menteeroll}',
    headers: {
     HttpHeaders.authorizationHeader: 'Bearer ${this.jwt}'
     });
   print('11111111111111111111111111');
   print(resp.headers['status']);
   print('11111111111111111111111111');

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

  @override

  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: this.res,
      builder: (context, snapshot){
          
          if(snapshot.hasData){
           if(snapshot.data.status == '500')
              return Text("Server Error", style: TextStyle( color: config.fontColor, fontFamily: config.fontFamily, fontSize: 18),);
           
          else if (snapshot.data.status == '401')
              return Text("Forbidden not enough rights", style: TextStyle( color: config.fontColor, fontFamily: config.fontFamily, fontSize: 18 ),);
          
          else if (snapshot.data.status == '403')
           return Text("Unauthorized", style: TextStyle( color: config.fontColor, fontFamily: config.fontFamily, fontSize: 18 ),);

          else 
          return Container(
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 500.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
        itemCount: snapshot.data.submission.length + 1,
      itemBuilder: (context, index){

         if(snapshot.data.submission.length == 0)
         return Center(
           child:Text("No data found", style: TextStyle(fontSize: 20, color: config.fontColor, fontFamily: config.fontFamily ),));

         else 
         if(index == snapshot.data.submission.length)
         return null;

         else
         return Statsdis(snapshot.data.submission[index]['title'], double.tryParse(snapshot.data.submission[index]['basic']), double.tryParse(snapshot.data.submission[index]['adv'])) ;
      }
    ),
    );
    }

      else if (snapshot.hasError){
      return Text('${snapshot.error}', style: TextStyle(color: config.fontColor, fontFamily: config.fontFamily),);
      }   
      else return CircularProgressIndicator();

      });
  }
}

