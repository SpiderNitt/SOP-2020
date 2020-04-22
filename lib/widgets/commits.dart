import 'package:flutter/material.dart';
import '../others/config.dart';
import 'package:http/http.dart';
import 'dart:convert';



class Data {

List<String> commits, date;
String status, errormsg;

Data(this.commits, this.date, this.status);

factory Data.getdata(List json){
    List<String> commitList = [], dateList = [];
    json.forEach((element){
      commitList.add(element['commit']['message']);
      dateList.add(element['commit']['committer']['date']);
    });
    return Data(commitList, dateList, '200 OK'); 
 }

Data.error(this.status, this.errormsg);

}

class Commits extends StatefulWidget {

  String repo_det, gitacc;

  
  Commits(this.repo_det, this.gitacc);

  @override
  _CommitsState createState() => _CommitsState(this.repo_det, this.gitacc);
}

class _CommitsState extends State<Commits> {

  String repo_det, gitacc;
  dynamic res;

  _CommitsState(this.repo_det, this.gitacc);

  Future<Data> getdata() async{
  Response resp = await get('https://api.github.com/repos/chakki1234/$repo_det/commits');

  if(resp.headers['status'] == '200 OK' || resp.headers['status'] == '304 Not Modified')
  return Data.getdata(jsonDecode(resp.body));
  else 
  return Data.error(resp.headers['status'], json.decode(resp.body)['message']);
   }


  @override
  void initState(){
  super.initState();
  this.res = getdata();
  }

  @override
  Widget build(BuildContext context) {
    return 
    FutureBuilder( 
      future: this.res, 
      builder: (context, snapshot){

      if(snapshot.hasData){
      
      if(snapshot.data.status == '200 OK')
      return Container(
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 360.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
      itemCount: (snapshot.data.commits.length + 1),
      itemBuilder: (context, index){
        
        if(snapshot.data.commits.length == 0)
         return  Text('No commits yet', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor));
      
        else if(index == snapshot.data.commits.length)
        return null;

        else return  Column(
           children: <Widget>[
            ListTile(
          contentPadding: EdgeInsets.all(3),
          title: Text(snapshot.data.commits[index],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          subtitle: Text(snapshot.data.date[index],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        Divider(
          color: config.fontColor,
        )
        ],
         );
      }
    ),
    );
    else 
        return Text("${snapshot.data.errormsg}", style: TextStyle( color: config.fontColor ),);
   }
       else if(snapshot.hasError)
       return Text("${snapshot.error}", style: TextStyle(color: config.fontColor),); 

       else return CircularProgressIndicator();

      });
  }
}