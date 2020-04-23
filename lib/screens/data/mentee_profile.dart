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
  String jwt= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc2OTQ0NjYsImZ1bGxuYW1lIjoidGhyaXNoaWsgZ2F3ZCIsImdpdGh1Yl91c2VybmFtZSI6InRocmlzaGlrMTEwMTEiLCJpc19tZW50b3IiOmZhbHNlLCJyb2xsIjoiMTEwMTE4MDkyIiwidXNlcm5hbWUiOiJ0aHJpc2hpayBhbm5hIn0.iPt31uRT8zNBd1YC4ZAX2bCdDubGKvjMi8UhSgP5qAU";
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
     proflist.add(_profiles[profids["$i"]]);
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

  Profile_task(this.profno);
  
 Future<void> tasks()async{
  
  String jwt= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc2OTQ0NjYsImZ1bGxuYW1lIjoidGhyaXNoaWsgZ2F3ZCIsImdpdGh1Yl91c2VybmFtZSI6InRocmlzaGlrMTEwMTEiLCJpc19tZW50b3IiOmZhbHNlLCJyb2xsIjoiMTEwMTE4MDkyIiwidXNlcm5hbWUiOiJ0aHJpc2hpayBhbm5hIn0.iPt31uRT8zNBd1YC4ZAX2bCdDubGKvjMi8UhSgP5qAU";
  String url= "https://spider.nitt.edu/inductions20test/api/profile/$profno/";
  Map<String, String> headers =  
  {   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',};
  Response response = await get(url,headers: headers);
  int statusCode = response.statusCode;
  if(statusCode == 200){
  var parsedJson = json.decode(response.body);
  var _tasks=parsedJson["tasks"];
  this.mentor_name=parsedJson["mentor_name"];
  this.mentor_contact=parsedJson["mentor_contact"];
  List return_task=[];
  int task_no= parsedJson["tasks_no"];
  for(int i=0; i<task_no; i++)
  {
    return_task.add(_tasks["$i"]["task_title"]);
  }
  this.prof_task_title= return_task;
  }
   else{
    print("failed to load");
    
  }

}
}


