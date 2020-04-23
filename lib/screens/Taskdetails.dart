import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../others/config.dart';
import '../widgets/navigationbar.dart';
import '../others/jwtparse.dart';
import '../widgets/Taskdet.dart';
import 'package:http/http.dart';


class Tasklist extends StatefulWidget {
  @override
  _TasklistState createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  
  String jwt, roll;
  List<dynamic> profiles = [];
  dynamic res;
  @override

  Widget build(BuildContext context) {
  
    Map data = ModalRoute.of(context).settings.arguments;
    this.jwt = data['jwt'];
    this.res = tryParseJwt(this.jwt);
    this.roll = this.res["roll"];
 
  
    return Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Task details'),
        centerTitle: true,
        backgroundColor: config.appbarcolor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
          future: get('https://spider.nitt.edu/inductions20test/api/mentor/${this.roll}/profile', 
          headers: {
            HttpHeaders.authorizationHeader : 'Bearer ${this.jwt}'
          }
          ),
          builder: (context, snapshot){

              if(snapshot.hasData){
              dynamic temp = jsonDecode(snapshot.data.body);
               for(int i = 0; i < temp["profile_ids"].length; ++i){
                this.profiles.add(temp["profile_ids"]['$i']);  
              }

             return TaskDet(this.jwt, this.profiles);
              }

             if(snapshot.hasError){
               return Text('${snapshot.error}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor));
             } 

             else return Center(
               child: CircularProgressIndicator());
          }),
        ),
        ),
      bottomNavigationBar: NavigationBar(0,this.jwt),
    );
  }
}