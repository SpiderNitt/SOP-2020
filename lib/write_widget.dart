import 'package:flutter/material.dart';
import 'navigationbar.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:io';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  
  double adv_percent, beg_percent;
  String review, jwt;
  final _formkey = GlobalKey<FormState>();
  
  
  @override

  Widget build(BuildContext context) {
  

  Map data = ModalRoute.of(context).settings.arguments;
  this.jwt = data['jwt'];

    return Scaffold(
    backgroundColor: config.bgColor,
    resizeToAvoidBottomPadding: true,
    appBar: AppBar(
      title: Text('Review'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: config.bgColor,
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
              this.setState((){
              this.review = value;
              });
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
            print(int.tryParse(value));
            if(value.isEmpty)
            return 'Please enter a pecentage';
            else if(int.tryParse(value)> 100)
            return 'Please enter a valid percentage';
            else{
              this.setState((){
              this.adv_percent = double.tryParse(value);
              });
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
             labelText: 'Advanced Task completion percentage',
             labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
             hintText: '',
          ),
          validator: (String value){
            print(int.tryParse(value));
            if(value.isEmpty)
            return 'Please enter a pecentage';
            else if(int.tryParse(value) > 100)
            return 'Please enter a valid percentage';
            else{
              this.setState((){
              this.beg_percent = double.tryParse(value);
              });
            return null;
            }
          },
          ), 
           SizedBox(height: 10),
         FlatButton(
          onPressed: (){
            if(_formkey.currentState.validate())
            {
               post('', 
                  headers: {
                    HttpHeaders.authorizationHeader: ''
                  },
                  body: {
                    "rollno": ""
                  });
              Scaffold.of(context).showSnackBar(
                   SnackBar(
                    backgroundColor: config.success,
                    content: Text('Submitted', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
                 )
                 );
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
