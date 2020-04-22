import 'package:flutter/material.dart';
import '../widgets/stats.dart';
import '../widgets/mentor_details.dart';
import '../widgets/navigationbar.dart';
import '../widgets/repodet.dart';
import '../others/config.dart';
import '../others/jwtparse.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MenteeTask extends StatefulWidget {

  @override
  _MenteeTaskState createState() => _MenteeTaskState();
}

class _MenteeTaskState extends State<MenteeTask> {
  
  dynamic res; 
  String jwt, menteeroll;

  // String value;
  // void readstorage() async{
  
  // final storage = new FlutterSecureStorage(); 
  // this.value = await storage.read(key: 'jwt');

  // }

  // @override
  // void initState(){
  //   super.initState();
  //   readstorage();
  // }

  @override
  Widget build(BuildContext context) {
   Map data = ModalRoute.of(context).settings.arguments;
   this.res = tryParseJwt(data['jwt']);
   this.jwt = data['jwt'];
   this.menteeroll = data['menteeroll'];

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
       child: Scaffold(
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
         automaticallyImplyLeading: false,
        elevation: 0,
           backgroundColor: config.appbarcolor,
        title: Text('Mentee task'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: config.fontColor,
          indicatorPadding: EdgeInsets.fromLTRB(35, 0, 35, 0),
          tabs: [
            Text('Repositories',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
            Text('Task details',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          ]),
      ),
      body: TabBarView(
        children: [
        SingleChildScrollView(
        child: Column(
        children: <Widget>[
        MenDet(data['name'], data['git']),
        SizedBox(height: 10),
        Text('Repositories',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        SizedBox(height: 10),
        RepoDet(data['git'], data['name'], this.jwt),
        ]
       ),
      ),

      SingleChildScrollView(
        child: Column(
        children: <Widget>[
        SizedBox(height: 20),  
        Text('Task details',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        SizedBox(height: 10),
        Stats(data['name'], data['git'], this.jwt, this.menteeroll), //remove unnecessary
        ]
       ),
      ),
        ]), 
      bottomNavigationBar: NavigationBar(0, this.jwt),
    ));
  }
}
