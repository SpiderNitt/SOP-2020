import 'package:flutter/material.dart';
import '../others/config.dart';
import '../others/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data{
  
  List<String> menteenames;
  dynamic status;
  
  Data(this.menteenames, this.status);
 
  factory Data.model(List res, dynamic stat) {
    
    List<String> temp = [];
    res.forEach((element){
      temp.add(element['title']);
    });
    return Data(temp, stat);
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

class MenteeDet extends StatefulWidget {

String jwttoken;  
dynamic rollno;

MenteeDet(this.jwttoken){
   this.rollno = tryParseJwt(this.jwttoken); //add fieldname
}
  @override
  _MenteeDetState createState() => _MenteeDetState(this.jwttoken);
}

class _MenteeDetState extends State<MenteeDet> {

String jwttoken;  
dynamic rollno;
dynamic res;

 _MenteeDetState(this.jwttoken){
   this.rollno = tryParseJwt(this.jwttoken); //add fieldname
}


  Future<Data>  getdata() async{
   Response resp = await get('https://jsonplaceholder.typicode.com/posts');
  
  if(resp.headers['status'] == '500')
   return  Data.for500();
  else if(resp.headers['status'] == '403')
   return Data.for403();
  else if(resp.headers['status'] == '401')
   return Data.for401();
  else 
   return Data.model(jsonDecode(resp.body), resp.headers['status']);
}
   @override
  void initState(){
  super.initState();
  this.res = getdata();
  }

  @override
   Widget build(BuildContext context) {
     return FutureBuilder(
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
        return Column(
          children: <Widget>[
            ListTile(
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: config.fontColor, ),
          contentPadding: EdgeInsets.all(3),
          onTap: (){
            Navigator.pushNamed(context, '/menteetask', arguments: {
              'name': snapshot.data.menteenames[index],
              'git': snapshot.data.menteenames[index],
              'jwt': this.jwttoken,
              'menteeroll': 107718015,
              //change here
            });
          },
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/android.png'),
          ),
          title: Text('${snapshot.data.menteenames[index]}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        Divider(
          color: config.fontColor,
          indent: 70,
        ),
        ],
        );
      }
    ),
    );
         }

         else return CircularProgressIndicator();

       }); 
  }
}



