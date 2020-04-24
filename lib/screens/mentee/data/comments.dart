
import 'package:inductions_20/screens/mentee/config/extractjwt.dart';
import 'package:inductions_20/screens/mentee/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Comments_list{
  
  List comments_details;
  int taskid;
  Comments_list(this.taskid);

  Future<void> extractComment() async{

    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
       
    try{   
    String url =
        "https://spider.nitt.edu/inductions20test/api/task/${taskid}";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',
    };
    Response response = await get(url, headers: headers);
    
    int statusCode = response.statusCode;
    if (statusCode == 200) {
    var parsedJson = json.decode(response.body);
    int comments_no=parsedJson["comments_no"];
    var commentsdetails=[];
    for(int i=0; i<comments_no; i++){

     var datetime=parsedJson["comments"]["$i"]["date_time"];
     String date = datetime.substring(0, 10);
       var  hr = int.parse(datetime.substring(11, 13)) + 5;
       var  min = int.parse(datetime.substring(14, 16)) + 30;
       var  sec = int.parse(datetime.substring(17, 19));
        if (min >= 60) {
          hr++;
          min = min - 60;
        }
        if (hr >= 24) {
          hr = hr - 24;
        }

       

      var  time= "$hr:$min:$sec";


    Map<String,String> comment={
        "name": "${parsedJson["comments"]["$i"]["link"]}",
        "comment":"${parsedJson["comments"]["$i"]["comment"]}",
        "date":"${date}",
        "time":"${time}"
      
      };
      commentsdetails.add(comment);
    }
    
   this.comments_details=commentsdetails;
      
    }
    else
    {
    print("failed to load");
    }
    }
    catch(e)
    {
       print("Server error");
    }

  }


}