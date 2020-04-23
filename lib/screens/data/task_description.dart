import 'package:inductions_20/screens/config/extractjwt.dart';
import 'package:inductions_20/screens/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class task_details{
  int task_no;
  String task_description;
  List <String> task_resources_desc;
  List <String> task_resources_link;
  int no_submissions;
  List comments;

  task_details(this.task_no) {

    ExtractTaskDetails();
  }
  ExtractTaskDetails() async{
  
  String jwt= provideJwt.jwt;
  String url= "https://spider.nitt.edu/inductions20test/api/task/${task_no}/";
  Map<String, String> headers =  
  {   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',};
  Response response = await get(url,headers: headers);
  int statusCode = response.statusCode;
  if(statusCode == 200){
  var parsedJson = json.decode(response.body);
  this.task_description=parsedJson["task_description"];
  int no_resources=parsedJson["resources_no"];
  this.no_submissions=parsedJson["no_of_submissions"];
  
  
  var resourceList =parsedJson["resources"];
  for(int i=0; i<no_resources; i++)
  {
   this.task_resources_desc.add(resourceList["$i"]["description"]);
   this.task_resources_link.add(resourceList["$i"]["link"]);
  }
   this.comments= parsedJson["comments"];
   
   
   }
  else{
     print("failed to load");
  }
  }


}

