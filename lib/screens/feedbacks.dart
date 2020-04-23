
import 'package:inductions_20/Themes/styling.dart';
import 'package:inductions_20/screens/task.dart';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/widgets/custom_comment.dart';

class TASKfeedback extends StatefulWidget{
  
  List task;
  TASKfeedback({this.task});

  TASKfeedbackState createState() => TASKfeedbackState(task);


}
class TASKfeedbackState extends State<TASKfeedback> with SingleTickerProviderStateMixin {


var taskdes;
List task;
TASKfeedbackState(this.task);
List<String> _messages;
List<String> date;
List<String> time;
TextEditingController textEditingController;
ScrollController scrollController;
 
  bool enableButton = false;
  @override
  void initState() {
     _messages = List<String>();
     time= List<String>();
     date=List<String>();
     
   task[3].forEach((k,v){
     _messages.add("$v");
  String date1= "$k".substring(0, 10);

  int hr =int.parse("$k".substring(11,13))-12+5;
   int min =int.parse("$k".substring(14,16))+30;
   int sec= int.parse("$k".substring(17,19));
  if(min>=60)
  { hr++;
    min=min-60;
   }
   date.add(date1);
   time.add("$hr:$min:$sec");

  
    });
     
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
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
    task= widget.task;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         backgroundColor: theme.primaryColor,
        appBar: AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
               Navigator.push(context, 
              MaterialPageRoute(builder: (context) =>TASK(task: task)),);
                 
        },), 
        title: Text('${task[0]} TASK ${task[1]}'),
        
        backgroundColor: theme.blackColor ,
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

                var messagebody = Comment_box(_messages[index],theme.tertiaryColor,theme.blackColor,commentwidth,'''Thrishik''',date[index],time[index]);
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

