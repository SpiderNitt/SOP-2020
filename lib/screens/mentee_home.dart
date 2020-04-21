import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:inductions_20/Themes/styling.dart';
import 'task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'widgets/custom_box.dart';

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



  var username="VishalS99";

  List<Color> clickcolor=[theme.tertiaryColor,theme.primaryLightColor,theme.primaryLightColor,theme.primaryLightColor];
  var list = ["WEB", "APP", "ALGO", "TRONIX"];
  var task="WEB";
  var user;
  void initState() {
    super.initState();
    this.user={
     "name": "username",
     "avatar_url":" ",
     "login":" "
    };
    makeRequest();
    }
  String url='https://api.github.com/users/'; 
  Future<String> makeRequest() async{
  http.Response response =await http.get(Uri.encodeFull(url+username), 
  headers: {"Accept":"application/json"});
  var user1= await json.decode(response.body);
  setState(() {
    this.user= user1;
   });
  }
  @override 
 
  
  
  double profilewidth;

  Widget build(BuildContext context) {

   
    final width = MediaQuery.of(context).size.width;
    if (width <= 400) {
      profilewidth=95;
    } else if (width <= 600) {
      profilewidth=95;
    } else if (width <= 900) {
     profilewidth=95;
    } else {
     profilewidth=320;
    }

  return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text("Profile"),
        elevation: 0,
        backgroundColor: theme.blackColor ,
        actions: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.more_vert, color: theme.fontColor),
          )],),
        body: SizedBox.expand(
        child: Stack(
        children: <Widget>[
        Container(
       
        height: 400,
        decoration: BoxDecoration(
        color: theme.blackColor,
        borderRadius: BorderRadius.circular(10)
          ),
        margin: EdgeInsets.all(30),
        child: Column(children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Padding(
            padding: const EdgeInsets.only(top:15),
            child: Column(
                   children:<Widget>[
                   Text('${this.user["name"]}',
                   style: TextStyle(
                   fontSize: 30,
                   fontWeight: FontWeight.bold,
                   color: theme.fontColor),
                    )] ) )],
           ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Padding(
            padding: const EdgeInsets.only(top:45),
            child:CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider('${this.user["avatar_url"]}'), 
                  radius:  90,
                 ))
               ],
           ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Padding(
            padding: const EdgeInsets.only(top:65),
            child: Row(
            children:<Widget>[
            Text('GitHub:  ',
            style: TextStyle(
                   fontSize: 24,
                   color: theme.fontColor,
                   fontWeight: FontWeight.bold
                    ),),
            Text('${this.user["login"]}',
            style: TextStyle(
                   fontSize: 24,
                   color: theme.tertiaryColor,
                   fontWeight: FontWeight.bold
                    ),)
             ] ) )
        ],),])),
        SizedBox.expand(
        child: DraggableScrollableSheet(
               initialChildSize: 0.25,
               minChildSize: 0.12,
               maxChildSize: 0.8,
               builder: (BuildContext c,s){
               var boxDecoration = BoxDecoration(
                                   color: Colors.grey,
                                   borderRadius: BorderRadius.circular(5),
                                    );
               var container = Container(
                               padding: EdgeInsets.symmetric(
                               horizontal: 15,
                               vertical: 10,
                               ),
                               decoration: BoxDecoration(
                               color: theme.blackColor,
                               borderRadius: BorderRadius.only(
                                             topLeft: Radius.circular(20.0),
                                             topRight: Radius.circular(20.0)
                               ),
                               boxShadow: [
                               BoxShadow(
                                 color: theme.fontColor,
                                 blurRadius: 2.0
                                 )
                               ]),
                               child: ListView(
                               controller: s,
                               children: <Widget>[
                                   Center(
                                   child: Container(
                                          height: 8,
                                          width: 50,
                                          decoration: boxDecoration,),),
                                   SizedBox(height: 50,),
                                   Container(
                                   height: 70, 
                                   width: 370, 
                                   color:theme.primaryColor,
                                   child: ListView(
                                          scrollDirection: Axis.horizontal ,
                                          children: <Widget>[
                                          for(int i=0; i<list.length; i++)
                                          Custom_box(list[i],(){
                                          setState(() {
                                            for(int j=0; j<list.length; j++){
                                               if(j==i) 
                                               clickcolor[j]= theme.tertiaryColor;
                                               else
                                               clickcolor[j]= theme.primaryLightColor;}
                                               task=list[i];});
                                                },profilewidth,80,15,clickcolor[i],20,3,10),
                                          ], ),
                                    ),         
                                   new Divider(
                                       color: theme.fontColor,
                                       height: 50,
                                       thickness: 3,
                                        ),
                                   for(int i=0; i<4; i++)
                                   Custom_box('${task} TASK ${i}',(){
                                            List a=[task,i,this.user];
                                            Navigator.push(context, 
                                            PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation)=>TASK(task: a),
                                            transitionsBuilder: (context, animation, secondaryAnimation, child){
                                              var animate = Tween<Offset>(
                                                     end: const Offset(1.0, 0.0),
                                                     begin: Offset.zero,
                                                     ).animate(secondaryAnimation);
                                              return SlideTransition(
                                              position: Tween<Offset>(
                                                begin: const Offset(1.0, 0.0),
                                                end: Offset.zero,
                
                                              
                                                ).animate(animation),
                                                child: SlideTransition(
                                                     position: animate,
                                                     child: child,
                                                ),
                                              );
                                            }
                                            )
                                            );
                                          }, 320,60,15,theme.secondaryColor,20,3,10),
                                         
                              
                                      ],
                                    ),
                                );
   return container;},),)])));
  }
}
