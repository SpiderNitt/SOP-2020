import 'dart:async';
import 'dart:io';
import 'widgets/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'widgets/custom_graph.dart';
import 'mentee_home.dart';
import 'comments.dart';
import 'feedbacks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';
import 'widgets/custom_comment.dart';
import 'task_description.dart';
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
  var submitbarcolor=0xffffffff;
  var user;
  var basic_per = 1.0;
  var advance_per=0.30;
  var overall_per;
  var decoverall_per;
  var view_count=56;
  List task;
  var decbasic_per;
   var decadvance_per;
     var decbasic_barper;
   var decadvance_barper;
   TextEditingController textEditingController;
  List taskSubmitted=['https://github.com/thrishik7/ML-algos','https://github.com/thrishik7/Networking-Kss'];
 
   List<Tab> myTabs = <Tab>[
    Tab(text: 'Description'),
    Tab(text: 'Progress'),
  ];

  TabController  _tabController;

 
  @override
  void initState() {
    super.initState();
      _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    )..addListener(() {
        setState(() {
          if(_tabController.index==1)
           submitbarcolor=secondary1;
          else
           submitbarcolor=0xffffffff;
        });
      });

     this.myTabs = <Tab>[
    Tab(text: 'Description'),
    Tab(text: 'Progress'),
  ];
  textEditingController = TextEditingController();
   this.overall_per=((this.basic_per+ this.advance_per)/2);
   this.decoverall_per=this.overall_per*100 ;
   decbasic_per=this.basic_per*100;
   decadvance_per= this.advance_per*100;
   decbasic_barper=this.basic_per*150;
   decadvance_barper= this.advance_per*150;

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
                    bottom: TabBar(
                    controller: _tabController,
                    tabs: myTabs  ),),

            floatingActionButton: _tabController.index ==0 ? 
            FloatingActionButton(
            backgroundColor: Color(0xffffffff),
            child: ListView(
            children: <Widget>[
            Padding(padding: const EdgeInsets.only(bottom:0),),
            Circular_percentage(48, 8, this.overall_per, Text("$decoverall_per"), 0xff80c904),
            ]
            )
            ): null,
            bottomNavigationBar:  Container(
                height: 50, 
                width: 370, 
                child: Material(
                  color: Colors.black,
                  elevation: 10.0,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Container(      
                  padding: EdgeInsets.only(left:10),
                  width:170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                   IconButton(
                   icon: Icon( Icons.done ,
                   color: Color(secondary1),
                   size: 20,),),
                   Padding(padding:const EdgeInsets.symmetric(vertical: 16.0),
                   child:  Text("${view_count} submission",
                   style: TextStyle(
                   fontWeight: FontWeight.bold,
                   color: Color(secondary1)
                   ) )),])),
                   Custom_box('Submit',(){
                   _tabController.animateTo((_tabController.index+1));},110,50,15,0xff000000,15,0,0),
                   Custom_box('Comments',(){
                                   List a=task;
                                   Navigator.push(context, 
                                   PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation)=>TASKcomments(task: a),
                                   transitionsBuilder: (context, animation, secondaryAnimation, child){
                                   return SlideTransition(
                                     position: Tween<Offset>(
                                     begin: const Offset(0.0, 1.0),
                                     end: Offset.zero,
                                     ).animate(animation),
                                child: SlideTransition(
                                     position: Tween<Offset>(
                                     end: const Offset(0.0, 1.0),
                                     begin: Offset.zero,
                                     ).animate(secondaryAnimation),
                                     child: child,
                                ),
                              );
                            }
                            )
                            ); },110,50,15, 0xff000000,15,0,0)
           ] ),), ),  
        body: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab){
              final String label = tab.text.toLowerCase();
              if(label!='progress')
                  return Task_description(primary);
              else {
        return ListView(
        children: <Widget>[
        Padding(
             padding: const EdgeInsets.all(0.0),
             child: Column(      
                    children: <Widget>[
                    Padding(padding: const EdgeInsets.all(16.0),
                    child: Container(
                           height: 30, 
                           width: 370, 
                           child: Material(
                                  color: Color(primary),
                                  child: Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Custom_box('Contact Thrishik ',(){},150,50,16,primary,0,0,0),
                    Custom_box('(992993922)',(){ launch("tel://21213123");},90,20,14,primary,0,0,0),
                    ],),), )),
                    Container(
                    margin:  const EdgeInsets.all( 10.0),
                    padding: const EdgeInsets.only(left:18.0),
                    decoration: BoxDecoration(
                                color: Color(secondary),
                                borderRadius: BorderRadius.circular(10)
                            ),
                    child: TextField(
                    style: TextStyle(
                    color: Colors.white,
                    ),
                    decoration: InputDecoration.collapsed(
                    hintText: "               Submit the Link of the task",
                    hintStyle:(TextStyle(color: Colors.white24 )),
                    fillColor: Colors.white
              ),
             controller: textEditingController,
            ),
          ),
          Custom_box('Submit',(){  
                              var text = textEditingController.value.text;
                              textEditingController.clear();
                              setState(() {
                              taskSubmitted.add(text);
                               });},68,38,14,secondary1,10,3,10),
          Container(
          child: Column(
                 children: <Widget>[
                 Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                   Padding( 
                   padding:const EdgeInsets.all(15.0),
                   child:Text("Submited Links:", style: TextStyle(color: Colors.white,
                   fontWeight: FontWeight.bold),)),]
                 ),
                for(int i=0; i<taskSubmitted.length; i++)
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Custom_box('${taskSubmitted[i]}',(){  
                  launch('${taskSubmitted[i]}');},320,38,15,primary1,10,3,0),
                  IconButton(
                      icon: Icon( Icons.clear ,
                      color: Colors.white,
                      size: 20,), onPressed:(){
                                          setState(() {
                                          taskSubmitted.remove(taskSubmitted[i]);
                                          });
                 },),
                ]
    ),],), ) ],)),
    new Divider(
    color: Colors.white,
    height: 50,
    thickness: 1,),
    Row(
    children:<Widget>[
            Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, bottom: 8.0, right: 8.0),
                  child: CircleAvatar(
                         backgroundImage: NetworkImage('${task[2]["avatar_url"]}'),
                         ),
            ),
            Padding(padding: const EdgeInsets.only(left:12.0),
            child: CustomPaint(painter: Triangle(),)),
            Comment_box('you got to change some features, \n add extra features and commit', secondary1,0xffffffff),
            ]),
    Custom_box('Previous feedbacks',(){
                            List a=task;
                            Navigator.push(context, 
                            PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation)=>TASKfeedback(task: a),
                            transitionsBuilder: (context, animation, secondaryAnimation, child){
                            return SlideTransition(
                            position: Tween<Offset>(
                                begin: const Offset(0.0, 1.0),
                                end: Offset.zero,

                              
                                ).animate(animation),
                                child: SlideTransition(
                                     position: Tween<Offset>(
                                     end: const Offset(0.0, 1.0),
                                     begin: Offset.zero,
                                     ).animate(secondaryAnimation),
                                     child: child,
                                ),
                              );
                            }
                            )
                            );},320,50,14.5,0xff000000,15,10,0)    ,   
    Container(
    margin: const EdgeInsets.only(top:30.0, left:10, right: 10),
    padding: const EdgeInsets.all(20.0),
    color: Colors.black,
    child: Column(
    children: <Widget>[
    TextFormField(
    style: TextStyle(
           color: Colors.white
           ),
    decoration: InputDecoration(
    labelText:'                 add a comment with the request',
    labelStyle: TextStyle(
    color: Colors.white,
    fontSize: 15
    ) ),   ),
    Custom_box('                Send Request to Review',(){},420,50,14.5,secondary1,15,8,10),
    ],)),

    Padding(padding: const EdgeInsets.only(bottom:40),),

    Circular_percentage(180.0,15.0, this.advance_per, 
            Circular_percentage(130.0, 15.0,this.basic_per,Text("$decoverall_per", style: TextStyle(color: Colors.white),),secondary1)
            , 0xff80c904),
    Container(
    margin: const EdgeInsets.only(bottom:20, left:10, right: 10),
    padding: const EdgeInsets.all(20.0),
    color: Colors.black,
    child: Table(
    children:[
          TableRow(
          children: <Widget>[
          Padding( padding:const EdgeInsets.only(bottom:15.0, top:2),
            child:Text("Completion",
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold),)),
            Padding( padding:const EdgeInsets.only(bottom:15.0, top:2),
            child:Text(" ")),
            ]),
          TableRow(
          children: <Widget>[
          Row(
            children:<Widget>[
            Container(width: decbasic_barper, height: 15, 
                      color: Colors.blue,),]),
            Container(width: 150, height: 40, 
                      padding: const EdgeInsets.only (top:0, left:10),
                      child: Text('Basic Task : ${decbasic_per} %', style: TextStyle(color: Colors.white, ),),
                      )
                    ]
          ),
          TableRow(
          children: <Widget>[
          Row(
            children:<Widget>[
            Container(width: decadvance_barper, height: 15, 
                      color: Colors.green,
                      ) ]),
            Container(width: 150, height: 40, 
                      padding: const EdgeInsets.only (top:0, left:10),
                      child: Text('Advance Task : ${decadvance_per} %', style: TextStyle(color: Colors.white, ),),
                      )
                    ]
                 )
               ]))
]);
             }    
     
           }).toList(),
        ), ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }}
