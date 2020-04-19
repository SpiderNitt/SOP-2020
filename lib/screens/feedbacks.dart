import 'dart:async';
import 'dart:io';
import 'task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'mentee_home.dart';
import 'widgets/custom_comment.dart';

class TASKfeedback extends StatefulWidget{
  
  List task;
  TASKfeedback({this.task});

  TASKfeedbackState createState() => TASKfeedbackState();


}
class TASKfeedbackState extends State<TASKfeedback> with SingleTickerProviderStateMixin {

  var primary=0xff00171f;
  var secondary= 0xff003459;
  var primary1= 0xff007ea7;
  var secondary1= 0xff00a8e8;
  var taskdes;
 var task; 
 List<String> _messages;
TextEditingController textEditingController;
ScrollController scrollController;
 
  bool enableButton = false;
  @override
  void initState() {
     _messages = List<String>();
    _messages.add("change your name");
        _messages.add("saniod adhajbdc eazkjsbnck");
            _messages.add("change your namesa sdhvui sdbvjshd jkdsbnc \n dncjds");
            
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
}


  

  @override
  Widget build(BuildContext context) {
   
    task= widget.task;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         backgroundColor:  Color(primary),
        appBar: AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
               Navigator.push(context, 
              MaterialPageRoute(builder: (context) =>TASK(task: task)),);
                 
        },), 
        title: Text('${task[0]} TASK ${task[1]}'),
        
        backgroundColor: Color(0xff000000) ,
        ),
        
              body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
              
                var avatar = Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                  child: CircleAvatar(
                    child: Text("A"),
                  ),
                );

                var triangle = CustomPaint(
                  painter: Triangle(),
                );

                var messagebody = Comment_box(_messages[index], secondary1, 0xff000000);
                Widget message;


                  message = Stack(
                    children: <Widget>[
                      Positioned(left: 0, bottom: 0, child: triangle),
                      messagebody,
                    ],
                  );
          

          

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
         
              },
            ),
          ),

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

