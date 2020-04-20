import 'package:flutter/material.dart';
import 'config.dart';
import 'jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data{
  
  List<String> menteenames;
  
  Data(this.menteenames);
 
  factory Data.model(List res) {
    
    List<String> temp = [];
    for(int i = 0; i < res.length; i++ )
      temp.add(res[i]['title']);
    return Data(temp);
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
   print(resp);
   return Data.model(jsonDecode(resp.body));
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

         else if(snapshot.hasError){
           return Text("${snapshot.error}", style: TextStyle(color: config.fontColor),);
         }

         else return CircularProgressIndicator();

       }); 
  }
}



