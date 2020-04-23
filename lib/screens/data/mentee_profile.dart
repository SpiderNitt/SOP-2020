import 'package:inductions_20/screens/config/extractjwt.dart';
import 'package:inductions_20/screens/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';


class Mentee_profile{

List profilelist;
List profnolist;
Mentee_profile();

Future<void> ExtractResponse()async{
  List _profiles = [
    'Algos',
    'App AN',
    'App Flutter',
    'App RN',
    'Tronix ES&AE',
    'Tronix R&C',
    'Tronix SP&ML',
    'WEB'
  ];
 profnolist=[];
  String jwt= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc3NDIzMTcsImZ1bGxuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIiwiZ2l0aHViX3VzZXJuYW1lIjoidGhyaXNoaWs3IiwiaXNfbWVudG9yIjpmYWxzZSwicm9sbCI6IjExMDExODA5MiIsInVzZXJuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIn0.mGC_haK5mPRpt6eZ4C6DA3F0bmCgEyMTjoFvPTf6aOg";
  var res= tryParseJwt(jwt);
  var rollno= res["roll"];
  String url= "https://spider.nitt.edu/inductions20test/api/mentee/${rollno}/profile";
  Map<String, String> headers =  
  {   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',};
  Response response = await get(url,headers: headers);
  
  int statusCode = response.statusCode;
  if(statusCode == 200){
  var parsedJson = json.decode(response.body);
  
  var profids= parsedJson["profile_ids"];
  List proflist=[];
  int prof_id_no = parsedJson["profiles_ids_no"];
  for(int i=0; i<prof_id_no; i++ )
  {
     proflist.add(_profiles[profids["$i"]-1]);
     this.profnolist.add(profids["$i"]);
  }
   this.profilelist= proflist;
   
  }
  else{
    print("failed to load");

  }
 
}

}

class Profile_task {
  
  int profno;
  String mentor_name;
  String mentor_contact;
  
  List prof_task_title;
  List taskno_list;

  Profile_task(this.profno);
  
 Future<void> tasks()async{
  
  String jwt= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc3NDIzMTcsImZ1bGxuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIiwiZ2l0aHViX3VzZXJuYW1lIjoidGhyaXNoaWs3IiwiaXNfbWVudG9yIjpmYWxzZSwicm9sbCI6IjExMDExODA5MiIsInVzZXJuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIn0.mGC_haK5mPRpt6eZ4C6DA3F0bmCgEyMTjoFvPTf6aOg";
  
  String url= "https://spider.nitt.edu/inductions20test/api/profile/$profno";
  Map<String, String> headers =  
  {   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',};
  Response response = await get(url,headers: headers);
  int statusCode = response.statusCode;
  if(statusCode == 200){
  var parsedJson = json.decode(response.body);
  var _tasks=parsedJson["tasks"];

  List return_task=[];
  List task_no_list=[];
  int task_no= parsedJson["tasks_no"];
  for(int i=0; i<task_no; i++)
  {
    return_task.add(_tasks["$i"]["task_title"]);
    task_no_list.add(_tasks["$i"]["task_id"]);
  }
  this.prof_task_title= return_task;
  this.taskno_list= task_no_list;
  }
   else{
    print("failed to load");
    
  }

}
}



class Mentor_details {
  
  int profno;
  String mentor_name;
  String mentor_contact;


  Mentor_details(this.profno);
  
 Future<void> mentor_extract()async{
  
  String jwt= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc3NDIzMTcsImZ1bGxuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIiwiZ2l0aHViX3VzZXJuYW1lIjoidGhyaXNoaWs3IiwiaXNfbWVudG9yIjpmYWxzZSwicm9sbCI6IjExMDExODA5MiIsInVzZXJuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIn0.mGC_haK5mPRpt6eZ4C6DA3F0bmCgEyMTjoFvPTf6aOg";
  var res= tryParseJwt(jwt);
  var rollno= res["roll"];
  String url= "https://spider.nitt.edu/inductions20test/api/mentee/$rollno/profile/$profno";
  Map<String, String> headers =  
  {   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',};
  Response response = await get(url,headers: headers);
  int statusCode = response.statusCode;
  if(statusCode == 200){
  var parsedJson = json.decode(response.body);
  this.mentor_contact=parsedJson["mentor_contact"];
  this.mentor_name=parsedJson["mentor_name"];

  }
   else{
    print("failed to load");
    
  }

}
}