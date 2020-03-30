import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      debugShowCheckedModeBanner: false,
      home: _MyHomePage()
       );
  }
}

class _MyHomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff000000),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text("Profile"),
        elevation: 0,
        backgroundColor: Color(0xff007ea7),
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
                        SizedBox(height: 20,),
                      Container(
                    height: 70, 
                    width: 370, 
                      
                    color:Color(0xff003459),
                    child: ListView(
                      scrollDirection: Axis.horizontal ,
                      children: <Widget>[
                        
                        Card(
                          elevation: 20,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            color: Color(0xff007ea7),
                            width:80,
                            child: Text('WEB',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ), ),
                          ),),               Card(
                          elevation: 20,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            color: Color(0xff007ea7),
                            width:80,
                            child: Text('APP',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ), ),
                          ),),               Card(
                          elevation: 20,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            color: Color(0xff007ea7),
                            width:80,
                            child: Text('ALGO',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ), ),
                          ),),               Card(
                          elevation: 20,
                          child: Container(
                            
                            padding: EdgeInsets.all(20),
                            color: Color(0xff007ea7),
                            
                            width:100,
                            child: Text('TRONIX',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        
                                      ), ) ,
                    
                 ),),
             ], 
           ),
         
         )
                     
                     
                     
                     
                     
                      ],
                    ),
                );
              },
            ),
         
         
          )
          
          
          
          
          ])));
  }
}
