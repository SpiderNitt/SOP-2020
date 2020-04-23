import 'dart:convert';

import 'package:flutter/material.dart';
import '../widgets/navigationbar.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:io';
import '../others/jwtparse.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  
  int adv_percent, basic;
  String review, jwt, mentorroll;
  dynamic id;
  final _formkey = GlobalKey<FormState>();
  
  
  @override

  Widget build(BuildContext context) {
  

  Map data = ModalRoute.of(context).settings.arguments;
  this.jwt = data['jwt'];
  this.id = data['id'];
  this.mentorroll = tryParseJwt(this.jwt)['roll'];

    return Scaffold(
    backgroundColor: config.bgColor,
    resizeToAvoidBottomPadding: true,
    appBar: AppBar(
       automaticallyImplyLeading: false,
      title: Text('Review'),
      centerTitle: true,
      elevation: 0,
         backgroundColor: config.appbarcolor,
    ),
    body: Builder(
      builder: (context) => SingleChildScrollView(
     child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
         child: Center(
           child: Text('Review for ${data['repo_det']}', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
         ),
        ),
          Container(
          padding: EdgeInsets.all(30),
          child:  Form(
          key: _formkey,
          child:  Column(
            children: <Widget>[

            TextFormField(
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
             labelText: 'Your Review',
             labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
             hintText: '',
          ),
          validator: (String value){
            if(value.isEmpty)
            return 'Please write your review';
            else{
            this.review = value;
            return null;
            }
          },
          ),
        SizedBox(height: 10),

        TextFormField(
          keyboardType: TextInputType.number,
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
             labelText: 'Basic Task completion percentage',
             labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
             hintText: '',
          ),
          validator: (String value){
              if(value.isEmpty)
            return 'Please enter a pecentage';
            else if(int.tryParse(value) > 100)
            return 'Please enter a valid percentage';
            else{
              this.basic = int.tryParse(value);
            return null;
          }
          }
          ),   
          SizedBox(height: 10),

          TextFormField(
          keyboardType: TextInputType.number,
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
             labelText: 'Advanced Task completion percentage',
             labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
             hintText: '',
          ),
          validator: (String value){
            if(value.isEmpty)
            return 'Please enter a pecentage';
            else if(int.tryParse(value) > 100)
            return 'Please enter a valid percentage';
            else{
              this.adv_percent = int.tryParse(value);
            return null;
            }
          },
          ), 
           SizedBox(height: 10),
         FlatButton(
          onPressed: ()async{
            if(_formkey.currentState.validate())
            {
               post('https://spider.nitt.edu/inductions20test/api/mentor/submissionFeedback', 
                  headers: {
                    HttpHeaders.authorizationHeader: 'Bearer ${this.jwt}'
                  },
                  body: jsonEncode({ 
                    "mentor_rollno": this.mentorroll,
                    "submission_id": this.id,
                    "review_message" : this.review,
                      "basic_task_percent" : this.basic,
                      "advanced_task_percent" : this.adv_percent
                  })).then((Response resp){
                    print(resp.statusCode);
                    Scaffold.of(context).showSnackBar(
                    SnackBar(
                    backgroundColor: config.success,
                    content: Text('Submitted', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
                 )
                 );
                }).catchError((Response error){
                    Scaffold.of(context).showSnackBar(
                    SnackBar(
                    backgroundColor: config.danger,
                    content: Text('Error', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
                 )
                 );
                });
            }
            else
            print('failure');
          },
          child: Text('Send', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
         ),       
          ],
          )
          ),
         ),
      ]
    ),
    ),
    ), 
    bottomNavigationBar: NavigationBar(0, this.jwt),
    );
  }
}
