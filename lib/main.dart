import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      debugShowCheckedModeBanner: false,
      home: homepage()
       );
  }
}
class homepage extends StatefulWidget{
  @override 
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<homepage> {
  var primary=0xff00171f;
  var secondary= 0xff003459;
  var primary1= 0xff007ea7;
  var secondary1= 0xff00a8e8;
  
  var clickcolor=[0xff00a8e8,0xff007ea7,0xff007ea7,0xff007ea7];
  var list = ["WEB", "APP", "ALGO", "TRONIX"];
  var task="WEB";
  
  void changecolor(int prof){
    
    setState(() {
      for(int i=0; i<list.length; i++){
      
      if(i==prof)
       clickcolor[i]= secondary1;
      else
       clickcolor[i]= primary1;
      }
    task=list[prof];


    });
     
  }
  
@override 
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(primary),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text("Profile"),
        elevation: 0,
        backgroundColor: Color(0xff000000) ,
        actions: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.more_vert, color: Colors.white),
          )],

      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Center(child: Column(children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               
               children: <Widget>[
                 Padding(
                 padding: const EdgeInsets.only(top:15),
                 child: Column(
                   children:<Widget>[
                    Text('MENTEE name',
                             style: TextStyle(
                               fontSize: 30,
                               fontWeight: FontWeight.bold,
                               color: Colors.white
                             ),
                    )
                    ] ) )
               ],
           ),
           Row(mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               
               children: <Widget>[
                 Padding(
                 padding: const EdgeInsets.only(top:25),
                 child:CircleAvatar(
                   backgroundImage: AssetImage('assets/profile.png'),
                   radius:  90,
                 ))
               ],
           ),
            Row(mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Padding(
                 padding: const EdgeInsets.only(left:50,top:45),
                 child: Column(
                   children:<Widget>[
                    Text('GitHub :   ',
                             style: TextStyle(
                               fontSize: 24,
                               color: Colors.white,
                                fontWeight: FontWeight.bold
                             ),
                    )
                    ] ) )
          ],
        ),
            ])),
             SizedBox.expand(
            child: DraggableScrollableSheet(
              initialChildSize: 0.25,
              minChildSize: 0.12,
              maxChildSize: 0.8,
              builder: (BuildContext c,s){
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,

                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)
                    ),
                    boxShadow: [
                     BoxShadow(
                     color: Colors.grey,
                     blurRadius: 20.0
                     
                     )
                    ]),
                    child: ListView(
                      controller: s,
                      children: <Widget>[
                        Center(child: Container(
                          height: 8,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),),
                        SizedBox(height: 50,),
                      Container(
                    height: 70, 
                    width: 370, 
                      
                    color:Color(primary),
                    child: ListView(
                      scrollDirection: Axis.horizontal ,
                      children: <Widget>[
                                           
                      for(int i=0; i<list.length; i++)
                        
                        GestureDetector(
                        
                         onTap:(){ changecolor(i);},
                          
                          child: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.all(3),
                            
                            color: Color(clickcolor[i]),
                            width:95,
                            child: Text(list[i],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ), ),
                          ),),               
                         
             ], 
           ),
         
         ),         
         new Divider(
            color: Colors.black,
            height: 50,
            thickness: 6,
          ),
              for(int i=0; i<4; i++)
               GestureDetector(
                          child: Container(
                            
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.all(3),
                            
                            decoration: BoxDecoration(
                              color: Color(secondary),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('${task} TASK ${i}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        
                                        
                                      ), ) ,
                      ),),
              
                      ],
                    ),
                );
              },
            ),
         
         
          )
          
          
          
          
          ])));
  }
}
