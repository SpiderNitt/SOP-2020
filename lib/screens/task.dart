import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'mentee_home.dart';
import 'comments.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';
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

 floatingActionButton: _tabController.index ==0 ? 
 FloatingActionButton(
   backgroundColor: Color(0xffffffff),
  child: ListView(
   children: <Widget>[
    Padding(padding: const EdgeInsets.only(bottom:0),),
     new CircularPercentIndicator(
            
           radius: 48.0,
           lineWidth: 8.0,
           percent: (this.overall_per),
           center: new Text("$decoverall_per"),
          progressColor: Colors.green,         ),
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
              color: isLiked ? Colors.red :Colors.white,
              size: 20,
            );
          },
          likeCount: 15,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Colors.red : Colors.white;
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

                                InkWell(
                            onTap:(){ List a=task;
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
                            );},
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


                                InkWell(
                                   onTap: () => _tabController.animateTo((_tabController.index+1)),
                                   child: Container(
                                   padding: EdgeInsets.all(18),
                                   margin: EdgeInsets.all(0),
                                   width:120,
                                   child:  Text('Submit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(submitbarcolor)
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
          return ListView(
          children: <Widget>[
           
           Padding(
             padding: const EdgeInsets.all(0.0),
             
             child: Column(      children: <Widget>[
        
    
          
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
        
        
          InkWell(
          onTap: (){
                              var text = textEditingController.value.text;
                               textEditingController.clear();
            setState(() {
                  taskSubmitted.add(text);
            });
          },
          child: Container(
                            
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(3),
                            
                            decoration: BoxDecoration(
                              color: Color(secondary1),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Submit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        
                                        
                                      ), ) ,
                      )
  
              

                
              ),

          Container(
            child: Column(children: <Widget>[
              Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Padding( padding:const EdgeInsets.all(15.0),
                     child:Text("Submited Links:", style: TextStyle(color: Colors.white,
                     fontWeight: FontWeight.bold),)),]
              ),
              
              for(int i=0; i<taskSubmitted.length; i++)

               Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    InkWell(
                        
                         onTap:()=> launch('${taskSubmitted[i]}'),
                          
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(3),
                            
                            color: Color(primary1),
                            width: 320,
                            child: Text('${taskSubmitted[i]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ), ),
                          ),),   
                    IconButton(
              icon: Icon( Icons.clear ,
                                       color: Colors.white,
                                       size: 20,), onPressed:(){

                                         setState(() {
                                           taskSubmitted.remove(taskSubmitted[i]);
                                         });
                                       },),
                   ]
              ),


            ],),
          )
           
      ],)),
           new Divider(
            color: Colors.white,
            height: 50,
            thickness: 1,
          ),
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
         child: CustomPaint(
                  painter: Triangle(),
                )),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(secondary1) ,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('you got to change some features, add extra \n features and commit', 
                      style: TextStyle(color: Colors.white),),
                    ),
                  ),
                )

          ]),
        
        Container(
             margin: const EdgeInsets.only(top:80.0, left:10, right: 10),
             padding: const EdgeInsets.all(20.0),
            color: Colors.black,
             child: Column
             (
              
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
                  )

                      ),
             ),
            InkWell(
                            child: Container(
                            width: 420,
                            padding: EdgeInsets.only(left:90, top:20, bottom:20),
                            margin: EdgeInsets.only(top:30),
                            
                            decoration: BoxDecoration(
                              color: Color(secondary1),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Send Request to Review',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        
                                        
                                      ), ) ,
                      ),
            )
           ],)),

Padding(padding: const EdgeInsets.only(bottom:40),),
     new CircularPercentIndicator(

           radius: 180.0,
           lineWidth: 15.0,
           percent: (this.advance_per),
           center:new CircularPercentIndicator(
           animation: true,
           radius: 130.0,
           lineWidth: 15.0,
           percent: (this.basic_per),
           center: new Text("$decoverall_per", style: TextStyle(color: Colors.white),),
          progressColor: Colors.blue,         ),
      
          progressColor: Colors.green,         ),
      Padding(padding: const EdgeInsets.only(bottom:40),),

        Container(
             margin: const EdgeInsets.only(bottom:20, left:10, right: 10),
             padding: const EdgeInsets.all(20.0),
            color: Colors.black,
             child: Table
             (
              
               children:[

                   TableRow(
                    children: <Widget>[
                    Padding( padding:const EdgeInsets.only(bottom:15.0, top:2),
                     child:Text("Completion", style: TextStyle(color: Colors.white,
                     fontWeight: FontWeight.bold),)),
                      Padding( padding:const EdgeInsets.only(bottom:15.0, top:2),
                     child:Text(" ")),
                     

                     
                     ]
              ),
                 TableRow(
                   
          children: <Widget>[
                     Row(
                       children:<Widget>[
                      Container(width: decbasic_barper, height: 15, 
                      color: Colors.blue,
                      ),]),

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
class Triangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Color(0xff00a8e8);

    var path = Path();
    path.lineTo(10, 0);
    path.lineTo(0, -10);
    path.lineTo(-10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}