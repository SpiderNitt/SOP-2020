import 'package:flutter/material.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data {
  String gitacc, avatar_url, errormsg; 
  dynamic status;

  Data(List json){
      this.gitacc = json[0]['owner']['login'];
      this.avatar_url = json[0]['owner']['avatar_url'];
  }

//  Data.error(this.errormsg, this.status);
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
  
  return Data(json.decode(resp.body));
  // if(resp.headers['status'] == '200 OK')
  //  return  Data(json.decode(resp.body));
  // else 
  //   return Data.error(resp.headers['status'], json.decode(resp.body)['message']);
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
      
        //  if(snapshot.data.status == '200 OK')
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
        // else
        // return Text("${snapshot.data.errormsg}", style: TextStyle( color: config.fontColor ),);
       }
      else if(snapshot.hasError){
        print('amercia');
        return Text("${snapshot.error}", style: TextStyle( color: config.fontColor ),);
      }
      else   
      return CircularProgressIndicator();
        }),
      ),
    );
  }
}