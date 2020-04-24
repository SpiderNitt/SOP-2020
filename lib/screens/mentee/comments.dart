import 'dart:async';
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/task.dart';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_comment.dart';
import 'package:inductions_20/screens/mentee/data/comments.dart';

class TaskComment extends StatefulWidget {
  final List task;
  TaskComment({this.task});

  TaskCommentState createState() => TaskCommentState();
}

class TaskCommentState extends State<TaskComment>
    with SingleTickerProviderStateMixin {
  var taskdes;

  var task;
  List<Map<String,String>> taskmsg;
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

    _getcomments();

  }

  Future<void> _getcomments() async{

   Comments_list comments_list1 = Comments_list(task[1]);
   await comments_list1.extractComment();
   
   setState(() {
     this.taskmsg=comments_list1.comments_details;
   });

  
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
      commentwidth = 210;
    } else if (width <= 600) {
      commentwidth = 230;
    } else if (width <= 900) {
      commentwidth = 290;
    } else {
      commentwidth = 390;
    }
    var textInput = Row(
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
                  hintStyle: (TextStyle(color: Colors.white12)),
                  fillColor: theme.fontColor),
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
    task = widget.task;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Task(task: task)),
              );
            },
          ),
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

                  if (taskmsg[index]["name"]==this.task[2]["login"]) {
                    reverse = true;
                  }

                  var avatar = Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 8.0, right: 8.0),
                    child: CircleAvatar(
                      child: Text("A"),
                    ),
                  );

                  var triangle = CustomPaint(
                    painter: Triangle(),
                  );

                  var messagebody = Comment_box(
                      '''${taskmsg[index]["comment"]}''',
                      theme.tertiaryColor,
                      theme.blackColor,
                      commentwidth,
                      '''${taskmsg[index]["name"]}''',
                      '''${taskmsg[index]["date"]}''',
                      '''${taskmsg[index]["time"]}''');

                  Widget message;

                  if (reverse) {
                    message = Stack(
                      children: <Widget>[
                        messagebody,
                        Positioned(right: 0, bottom: 0, child: triangle),
                      ],
                    );
                  } else {
                    message = Stack(
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

  State<StatefulWidget> createState() => null;
}
