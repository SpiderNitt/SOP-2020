import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'main.dart';

class TASK extends StatefulWidget{
  
  List task;
  TASK({this.task});

  TASKState createState() => TASKState();


}
class TASKState extends State<TASK> with SingleTickerProviderStateMixin {

  var primary=0xff00171f;
  var secondary= 0xff003459;
  var primary1= 0xff007ea7;
  var secondary1= 0xff00a8e8;
  var taskdes;
  var view_count=56;
  List task;
 
   List<Tab> myTabs = <Tab>[
    Tab(text: 'Description'),
    Tab(text: 'Progress'),
  ];

  TabController  _tabController;

 
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);

     this.myTabs = <Tab>[
    Tab(text: 'Description'),
    Tab(text: 'Progress'),
  ];

 

    this.taskdes = "Description"; }

 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
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
              MaterialPageRoute(builder: (context) =>homepage()),);
                 
        },), 
        title: Text('${task[0]} TASK ${task[1]}'),
        
        backgroundColor: Color(0xff000000) ,
        actions: <Widget>[  
            // action button
            IconButton(
              icon: Icon( Icons.remove_red_eye ,
                                       color: Color(secondary1),
                                       size: 20,),),

          Padding(padding:const EdgeInsets.symmetric(vertical: 20.0),
          child:  Text("${view_count}", style: TextStyle(
  
                               fontWeight: FontWeight.bold,
                               color: Color(secondary1)
           ) )),
          Padding(padding: const EdgeInsets.only(left: 104.0),
                  child: Icon(Icons.more_vert, color: Colors.white),
          )],
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs         
            ),

      ),

 floatingActionButton: FloatingActionButton(
   backgroundColor: Color(0xffffffff),
  child: ListView(
   children: <Widget>[
    Padding(padding: const EdgeInsets.only(bottom:0),),
     new CircularPercentIndicator(

           radius: 48.0,
           lineWidth: 8.0,
           percent: 0.40,
           center: new Text("48"),
          progressColor: Colors.green,         ),
         ]
 )
 ),
       
       bottomNavigationBar:  Container(
              height: 80, 
                width: 370, 
                      
                child: Material(
                  color: Colors.black,
                  elevation: 10.0,
                 
  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                       GestureDetector(
                                   
                                   child: Container(
                                   padding: EdgeInsets.all(15),
                                   margin: EdgeInsets.all(0),
                                   width:150,
                                   child: LikeButton(
          size: 20,
          circleColor:
              CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite,
              color: isLiked ? Color(secondary1) : Colors.white,
              size: 20,
            );
          },
          likeCount: 15,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Color(secondary1) : Colors.white;
            Widget result;
            if (count == 0) {
              result = Text(
                "love",
                style: TextStyle(color: color),
              );
            } else
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            return result;
          },
        ),




                          ),),      

                                GestureDetector(
                                   onTap:(){ },
                                   child: Container(
                                   padding: EdgeInsets.all(18),
                                   margin: EdgeInsets.all(0),
                                   width:120,
                                   child: Text('Comments',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ), ),
                          ),),                            


                                GestureDetector(
                                   onTap:(){ },
                                   child: Container(
                                   padding: EdgeInsets.all(18),
                                   margin: EdgeInsets.all(0),
                                   width:120,
                                   child:  Text('Submit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ), ),
                          ),),                            
        



                    ],
                  )
                  ,), ),
  


        body: TabBarView(
          controller: _tabController,
          children: myTabs.map((Tab tab){
             final String label = tab.text.toLowerCase();
             if(label!='progress')
          return ListView(
            children:<Widget>[
              Padding(padding: const EdgeInsets.all(16.0),
              child: Container(
              height: 600, 
              width: 370, 
                      
                child: Material(
                  color: Color(primary),
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10.0),
  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${this.taskdes}', style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.white
                             ))
                    ],
                  ),), )),

              Padding(padding: const EdgeInsets.all(16.0),
              child: Container(
              height: 200, 
              width: 370, 
                      
                child: Material(
                  color: Color(primary),
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10.0),
  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(' Resources:', style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.white
                             ))
                    ],
                  )
                  ,), )),

          



            ]
            
          );
          else 
          return Column(
          children: <Widget>[
           
           Card(
            
             child: Column(children: <Widget>[
             TextFormField(

               decoration: InputDecoration(
                 labelText: 'Submit your Task'
               ),
             )
           ],),
             
)]);         
           }).toList(),
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