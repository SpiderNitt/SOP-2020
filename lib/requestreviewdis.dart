import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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

class Requestlist extends StatefulWidget {

String mentorname, mentorgitacc, jwt;  

Requestlist(this.mentorname, this.mentorgitacc, this.jwt);

  @override
  _RequestlistState createState() => _RequestlistState(this.mentorname, this.mentorgitacc, this.jwt);
}

class _RequestlistState extends State<Requestlist> {

  String mentorname, mentorgitacc, searchword = '', jwt;  

  final _formkey = GlobalKey<FormState>();

  dynamic resultobt, res; 

  _RequestlistState(this.mentorname, this.mentorgitacc, this.jwt);
 

  Future<Data>  getdata() async{
   Response resp = await get('https://jsonplaceholder.typicode.com/posts');
   return Data.model(jsonDecode(resp.body));
}
   @override
   void initState(){
   super.initState();
   this.res = getdata();
  }

List<Widget> listmaker(dynamic contxt){

List<Widget> finallist = [];

this.resultobt.forEach((element){

  if(element.contains(this.searchword) || this.searchword == ''){
    finallist.add(
      Column(
          children: <Widget>[
            ListTile(
          contentPadding: EdgeInsets.all(3),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/android.png'),
          ),
          title: Text('${element}', softWrap: true, style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   SizedBox(
                    height:5,
                  ),
                  Text('${element}', softWrap: true,  style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.fontColor)),
                  SizedBox(
                    height:5,
                  ),
                  Text('Repo link: http://github.com/chakki/dfgh/dsafgdhf/sdafghj/dfshk/dfshk/dfhjkl/dfshk/dsfhj',  softWrap: true, style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.fontColor)),
                   SizedBox(
                    height:5,
                  ),
                  Text('Not reviewed', softWrap: true, style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.danger)),
                  SizedBox(
                    height:5,
                  ),
                  FlatButton(
                  onPressed: (){
                  Navigator.pushNamed(contxt, '/writereview', arguments: {
                  'repo_det': element,
                  'jwt': this.jwt
                   });
          }, 
         child: Text('Write a review', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
         ),
                ],
              ),
        ),
        Divider(
          color: config.fontColor,
          indent: 70,
        ),
        ],
        )
    );
  }

});

return finallist;
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.res,
      builder: (context, snapshot){
 
      if(snapshot.hasData){

      this.resultobt = snapshot.data.menteenames;
      return
      Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: <Widget>[
            
            Form(
          key: _formkey,
          child: TextFormField(
          cursorColor: config.fontColor,
          style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
          maxLines: null,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     width: config.bordWid,
                     color: config.fontColor,
                   ), 
                 ),
             labelText: 'Search',
             labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
          ),
          onChanged: (String value){
            this.setState(() {
              searchword = value;
            });
          },
          ),     
        ),

        Divider(
           color: config.fontColor,
        ),
   
      Container(
        child: Column(
        children: listmaker(context),
        ),
      ),
    ],
    ),
  );
        
      }

      else if(snapshot.hasError)
      return Center(
      child: Text("${snapshot.error}", style: TextStyle(color: config.fontColor),)
      );
         
      else return  Center(
          child: CircularProgressIndicator(),
        );
      });
  }
}
