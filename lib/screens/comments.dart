import 'dart:async';
import 'dart:io';
import 'package:inductions_20/Themes/styling.dart';

import 'task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'mentee_home.dart';
import 'widgets/custom_comment.dart';
class TASKcomments extends StatefulWidget{
  
  List task;
  TASKcomments({this.task});

  TASKcommentsState createState() => TASKcommentsState();


}
class TASKcommentsState extends State<TASKcomments> with SingleTickerProviderStateMixin {


var taskdes;
var task; 
List<String> _messages;
TextEditingController textEditingController;
ScrollController scrollController;
 
  bool enableButton = false;
  @override
  void initState() {
     _messages = List<String>();

    textEditingController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
}

  void handleSendMessage() {
    var text = textEditingController.value.text;
    textEditingController.clear();
    setState(() {
      _messages.add(text);
      enableButton = false;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          curve: Curves.ease, duration: Duration(milliseconds: 500));
    });
  }

  
  double commentwidth;
  @override
  Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width <= 400) {
   commentwidth=210;} else if (width <= 600) {
   commentwidth=230;} else if (width <= 900) {
   commentwidth=290;} else {
   commentwidth=390;}  
   var textInput =Row(
            
      children: <Widget>[
        
        Expanded(
          
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
          
            child: TextField(
              onChanged: (text) {
                setState(() {
                  enableButton = text.isNotEmpty;
                });
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration.collapsed(
                hintText: "Type a comment",
                hintStyle:(TextStyle(color: Colors.white12 )),
                fillColor: theme.fontColor
              ),
              controller: textEditingController,
            ),
          ),
        ),
        enableButton
            ? IconButton(
                color: theme.tertiaryColor,
                icon: Icon(
                  Icons.send,
                ),
                disabledColor: theme.fontColor,
                onPressed: handleSendMessage,
              )
            : IconButton(
                color: theme.tertiaryColor,
                icon: Icon(
                  Icons.send,
                ),
                disabledColor: theme.fontColor,
                onPressed: null,
              )
      ],
    );
    task= widget.task;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         backgroundColor:  theme.primaryColor,
         appBar: AppBar(

         leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
               Navigator.push(context, 
              MaterialPageRoute(builder: (context) =>TASK(task: task)),);
                 
        },), 
        title: Text('${task[0]} TASK ${task[1]}'),
        
        backgroundColor: theme.blackColor,
        ),
        
              body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool reverse = false;

                if (index == 0) {
                  reverse = true;
                }

                var avatar = Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                  child: CircleAvatar(
                    child: Text("A"),
                  ),
                );

                var triangle = CustomPaint(
                  painter: Triangle(),
                );
                
                var messagebody = 
                Comment_box(_messages[index], theme.tertiaryColor,theme.blackColor,commentwidth,'''Thrishik''');
             

                Widget message;

                if (reverse) {
                  message = Stack(
                    children: <Widget>[
                      messagebody,
                      Positioned(right: 0, bottom: 0, child: triangle),
                    ],
                  );
                } else {
                  message =Stack(
                    children: <Widget>[
                      Positioned(left: 0, bottom: 0, child: triangle),
                      messagebody,
                    ],
                  );
                }

                if (reverse) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: message,
                      ),
                      avatar,
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      avatar,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: message,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Divider(height: 2.0),
          textInput
        ],
      ),

          
        
           ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

