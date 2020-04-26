import 'package:inductions_20/screens/mentee/config/extractjwt.dart';
import 'package:inductions_20/screens/mentee/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Comments_list {
  List comments;
  List user;
  List dates;
  List time;
  var username;
  List pos;
  int taskid;
  Comments_list(this.taskid);

  Future<void> extractComment() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    var res = tryParseJwt(jwt);

    this.username = res["username"];
    try {
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
        int comments_no = parsedJson["comments_no"];

        comments = [];
        user = [];
        dates = [];
        time = [];
        pos=[];
        for (int i = 0; i < comments_no; i++) {
          var datetime = parsedJson["comments"]["$i"]["date_time"];
          String date = datetime.substring(0, 10);
          var hr = int.parse(datetime.substring(11, 13));
          var min = int.parse(datetime.substring(14, 16));
          var sec = int.parse(datetime.substring(17, 19));

          var times = "$hr:$min";

          user.add(parsedJson["comments"]["$i"]["link"]);
          comments.add(parsedJson["comments"]["$i"]["comment"]);
          dates.add("$date");
          time.add("$times");
          pos.add(parsedJson["comments"]["$i"]["is_mentor"]);
        }
      } else {
        print("failed to load");
      }
    } catch (e) {
      print("Server error");
    }
  }
}
