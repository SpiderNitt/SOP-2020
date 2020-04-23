import 'package:inductions_20/screens/config/extractjwt.dart';
import 'package:inductions_20/screens/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class mentee_progress{

int task_no;
double basic_per;
double advance_per;
List submitted_links;
Map previous_feedbacks;
var recent_feedback;

 
mentee_progress(this.task_no)
{
  ExtractProgressDetails();
}
 ExtractProgressDetails() async{

  String jwt= provideJwt.jwt;
  var res= tryParseJwt(jwt);
  var rollno= res["rollno"];
  String url= "https://spider.nitt.edu/inductions20test/api/mentee/${rollno}/task/${this.task_no}/progress";
  Map<String, String> headers =  
  {   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',};
  Response response = await get(url,headers: headers);
  
   int statusCode = response.statusCode;
   if(statusCode == 200){
   var parsedJson = json.decode(response.body);
   int sub_no= parsedJson["submission_no"];
   sub_no=sub_no-1;
   var submissions=parsedJson["submissions"];
   this.basic_per=submissions["$sub_no"]["basic_task_percent"];
   this.advance_per=submissions["$sub_no"]["advanced_task_percent"];
   int no_links= submissions["$sub_no"]["submission_links_no"];
   for(int i=0; i<no_links; i++)
   {
     submitted_links.add(submissions["$sub_no"]["submission_links"]['$i']);
   }
   var feed_time;
   for(int i=0; i<=sub_no; i++)
   {
     if(submissions["$i"]["is_reviewed"]==true)
    {  
     feed_time= submissions["$i"]["feedback_date_time"];
      this.previous_feedbacks["${feed_time}"]=submissions["$i"]["feedback"];
       
    }   
   }
    
     this.recent_feedback=feed_time;   
   }

  else{
    print("failed to load");
  }
 
 
 } 

}


