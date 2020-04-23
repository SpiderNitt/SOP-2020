import 'package:inductions_20/screens/announcement.dart';
import 'package:inductions_20/screens/config/extractjwt.dart';
import 'package:inductions_20/screens/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';
class Announcement_list{

Map announcements;

 
Announcement_list();

 Future<void> extractProgressDetails() async{

  String jwt= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODc3NDIzMTcsImZ1bGxuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIiwiZ2l0aHViX3VzZXJuYW1lIjoidGhyaXNoaWs3IiwiaXNfbWVudG9yIjpmYWxzZSwicm9sbCI6IjExMDExODA5MiIsInVzZXJuYW1lIjoiVGhyaXNoaWsgU2VudGhpbGt1bWFyIn0.mGC_haK5mPRpt6eZ4C6DA3F0bmCgEyMTjoFvPTf6aOg";

  String url= "https://spider.nitt.edu/inductions20test/api/announcements";
  Map<String, String> headers =  
  {   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',};
  
   Response response = await get(url, headers: headers);
  
   int statusCode = response.statusCode;
   if(statusCode == 200){
      var parsedJson = json.decode(response.body);
      var an= parsedJson["Announcements_no"];
      var date;
      var desc;
      announcements={};
      for(int i=0; i<an; i++)
      {
        date= parsedJson["Announcements"]["$i"]["date_time"];
        desc= parsedJson["Announcements"]["$i"]["description"];
        announcements["$date"]="$desc";

      }
 }

 }
}