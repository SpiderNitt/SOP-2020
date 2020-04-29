
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '../../../theme/mentor.dart';
import 'package:inductions_20/screens/mentor/comments.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TaskDet extends StatefulWidget {
  final String _jwttoken;
  final List _profiles;
  TaskDet(this._jwttoken, this._profiles);

  @override
  _TaskDetState createState() => _TaskDetState(this._jwttoken, this._profiles);
}

class _TaskDetState extends State<TaskDet> {
  String jwttoken;
  dynamic res;
  List<dynamic> profiles;
  final storage = FlutterSecureStorage();

  _TaskDetState(this.jwttoken, this.profiles);

  Future<int> notify(dynamic taskid) async{
    print(taskid);
     Response res = await get(
                      'https://spider.nitt.edu/inductions20test/api/task/$taskid',
                      headers: {
                        HttpHeaders.authorizationHeader:
                            'Bearer ${this.jwttoken}'
                      });
    dynamic resmap = jsonDecode(res.body);

    dynamic rescomm =  await storage.read(key: '${taskid}_comments');
    
    
    if(rescomm == null) {
      return resmap['comments'].length;
    }
    else {
       return resmap['comments'].length - int.tryParse(rescomm);
    }

  }
   
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 650,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView.builder(
            itemCount: this.profiles.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                  future: get(
                      'https://spider.nitt.edu/inductions20test/api/profile/${this.profiles[index]}',
                      headers: {
                        HttpHeaders.authorizationHeader:
                            'Bearer ${this.jwttoken}'
                      }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic temp = jsonDecode(snapshot.data.body);

                      List<Widget> tempwid = [];

                      if (temp['tasks'].length != 0) {
                        for (int j = 0; j < temp['tasks'].length; ++j) {
                          tempwid.add(Container(
                              child: Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(
                                temp['tasks']['$j']['profile_task_count'],
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: config.fontFamily,
                                  color: Color(0xFF00A8E8),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(temp['tasks']['$j']['task_title'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: config.fontFamily,
                                      color: config.head)),
                              SizedBox(height: 10),
                              FutureBuilder(
                                  future: get(
                                      'https://spider.nitt.edu/inductions20test/api/task/${temp['tasks']['$j']['task_id']}',
                                      headers: {
                                        HttpHeaders.authorizationHeader:
                                            'Bearer ${this.jwttoken}'
                                      }),
                                  builder: (context, snapst) {
                                    if (snapst.hasData) {

                                     
                                 List<Widget> listlink = [];
                                 dynamic tempdes = jsonDecode(snapst.data.body);
                                 
                                 listlink.add(Text(tempdes['task_description'],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)));
                                 
                                 listlink.add(SizedBox(
                                   height: 10
                                 ));
                                 
                                 if(tempdes['resources'].length != 0)
                                 listlink.add(Text('Resources',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.head)));
                                  
                                 for(int k = 0; k < tempdes['resources'].length; ++k){
                                   listlink.add( InkWell(
                                       child: Text(tempdes['resources']['$k']['link'],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.links)),
                                       onTap: () async{
                                         if(await canLaunch('${tempdes['resources']['$k']['link']}'))
                                         launch('${tempdes['resources']['$k']['link']}');
                                       },
                                     ));

                                   listlink.add(Text(tempdes['resources']['$k']['description'],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)));
                                   listlink.add(SizedBox(
                                   height: 5
                                 ));
                                 } 
                                // added button here
                                listlink.add(
                                  FutureBuilder(
                                    future: notify(temp['tasks']['$j']['task_id']),
                                    builder: (context, snapshot){

                                      if(snapshot.hasData){

                                          return Stack(
                                  children: <Widget>[
                                    FlatButton(
                                  onPressed: () {
                                  storage.write(key: '${temp['tasks']['$j']['task_id']}_comments', value: '${tempdes['comments'].length}');

                                  List a = [temp['tasks']['$j']['task_title'],temp['tasks']['$j']['task_id'],this.profiles[index]];

                                   Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    TaskComment(task: a),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                            }));
                                  },
                                  child: Text('Discussions Forum',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: config.fontFamily,
                                          color: config.fontColor)),
                                ),
                                Positioned(
                                    right: 9,
                                    top: 9,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration:  BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 14,
                                        minHeight: 14,
                                      ),
                                      child: Text(
                                        '${snapshot.data}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ) 
                                  ],
                                );
                                      }

                                      else if(snapshot.hasError)
                                      return Text('${snapshot.error}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: config.fontFamily,
                                              color: config.fontColor));

                                      else return CircularProgressIndicator();
                                    })
                                );

                                  return Column(
                                    children: listlink
                                  );
                                  }

                                    if (snapst.hasError) {
                                      return Text('${snapst.error}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: config.fontFamily,
                                              color: config.fontColor));
                                    } else
                                      return CircularProgressIndicator();
                                  }),
                              Divider(color: config.fontColor)
                            ],
                          )));
                        }

                        return Column(children: tempwid);
                      } 
                      else return Text('');
                    }

                    if (snapshot.hasError)
                      return Text('${snapshot.error}',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: config.fontFamily,
                              color: config.fontColor));
                    else
                      return CircularProgressIndicator();
                  });
            }));
  }
}

