import 'package:inductions_20/screens/config/extractjwt.dart';
import 'package:inductions_20/screens/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Mentee_progress{

int task_no;
int basic_per;
int advance_per;
List submitted_links;
Map previous_feedbacks;
var recent_feedback;

 
Mentee_progress(this.task_no);

 Future<void> extractProgressDetails() async{

  String jwt= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc3NDIzMTcsImZ1bGxuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIiwiZ2l0aHViX3VzZXJuYW1lIjoidGhyaXNoaWs3IiwiaXNfbWVudG9yIjpmYWxzZSwicm9sbCI6IjExMDExODA5MiIsInVzZXJuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIn0.mGC_haK5mPRpt6eZ4C6DA3F0bmCgEyMTjoFvPTf6aOg";
  var res= tryParseJwt(jwt);
  var rollno= res["roll"];
  try{
  String url= "https://spider.nitt.edu/inductions20test/api/mentee/${rollno}/task/${this.task_no}/progress";
  Map<String, String> headers =  
  {   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',};
  Response response = await get(url,headers: headers);
  
   int statusCode = response.statusCode;
   if(statusCode == 200){
   var parsedJson = json.decode(response.body);
   int sub_no= parsedJson["submissions_no"];
   sub_no=sub_no-1;
   var submissions=parsedJson["submissions"];
   this.basic_per=submissions["$sub_no"]["basic_task_percent"];
   this.advance_per=submissions["$sub_no"]["advanced_task_percent"];
   int no_links= submissions["$sub_no"]["submission_links_no"];
   Map submission_links={};
   previous_feedbacks={};
   var submlinks= submissions["$sub_no"]["submission_links"];
   submission_links=jsonDecode(submlinks);

   submitted_links=[];
   for (int i=0; i<no_links; i++)
   {
     submitted_links.add(submission_links["$i"]);
   }
  
   var feed_time=" ";
   for(int i=0; i<=sub_no; i++)
   {
     if(submissions["$i"]["is_reviewed"]==true)
    {  
     feed_time= submissions["$i"]["feedback_date_time"];
      this.previous_feedbacks["${feed_time}"]=submissions["$i"]["feedback"];
     this.basic_per=submissions["$i"]["basic_task_percent"];
     this.advance_per=submissions["$i"]["advanced_task_percent"];
    }   
   }
    
     this.recent_feedback=feed_time;   
   }

  else{
    print("failed to load");
  }
 
  }
  catch(e)
  {
     
      basic_per=0;
      advance_per=0;
      submitted_links=[];
      previous_feedbacks={};
      recent_feedback="5:30";
  }
 
 } 

}


