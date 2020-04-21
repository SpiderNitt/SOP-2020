import 'package:flutter/material.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data {
  String gitacc, avatar_url;
  dynamic status;

  Data(List json, dynamic stat){
      this.gitacc = json[0]['owner']['login'];
      this.avatar_url = json[0]['owner']['avatar_url'];
      this.status = stat;
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
  
  if(resp.headers['status'] == '500')
   return  Data.for500();
  else if(resp.headers['status'] == '403')
   return Data.for403();
  else if(resp.headers['status'] == '401')
   return Data.for401();
  else  
  return Data(json.decode(resp.body), 200);
 
  }
  
  @override

  void initState() {
  super.initState();
  this.res = getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Center(
        child:  FutureBuilder<Data>(
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
      
       }
     
      else
     
      return CircularProgressIndicator();
        }),
      ),
    );
  }
}