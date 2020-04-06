import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Data {

List<String> commits;
List<String> date;

Data(this.commits, this.date);

factory Data.getdata(List json){
    List<String> commitList = [];
    List<String> dateList = [];
    json.forEach((element){
      commitList.add(element['commit']['message']);
      dateList.add(element['commit']['committer']['date']);
    });
    return Data(commitList, dateList); 
 }

}

class Commits extends StatefulWidget {


  String repo_det;
  
  Commits(this.repo_det);

  @override
  _CommitsState createState() => _CommitsState(this.repo_det);
}

class _CommitsState extends State<Commits> {

  String repo_det;
  dynamic res;

  _CommitsState(this.repo_det);

  Future<Data> getdata() async{
  Response resp = await get('https://api.github.com/repos/chakki1234/$repo_det/commits');
  return Data.getdata(jsonDecode(resp.body));
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

       if(snapshot.hasData)
      
       return Container(
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 360.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
      itemCount: (snapshot.data.commits.length + 1),
      itemBuilder: (context, index){
        print(index);
        if( index == snapshot.data.commits.length)
         
        return  FlatButton(
          
          onPressed: (){
            Navigator.pushNamed(context, '/writereview', arguments: {
              'repo_det': this.repo_det,
            });
          }, 
         child: Text('Write a review', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)));
         
         else return  Card(
        shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(config.borRadi)),
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(config.borRadi),
          border: Border.all(
            width: config.bordWid,
            color: config.bordColor,
          ),
          color: config.conColor,
        ),
          child: ListTile(
          contentPadding: EdgeInsets.all(3),
          title: Text(snapshot.data.commits[index],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          subtitle: Text(snapshot.data.date[index],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        ),
        );
      }
    ),
    );

       else if(snapshot.hasError)
       return Text("${snapshot.error}", style: TextStyle(color: config.fontColor),); 

       else return CircularProgressIndicator();

      });
  }
}