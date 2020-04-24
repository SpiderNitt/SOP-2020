import 'package:inductions_20/screens/mentee/config/extractjwt.dart'
    show ProvideJwt;
import 'package:inductions_20/screens/mentee/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class AnnouncementList {
  Map announcements;

  AnnouncementList();

  Future<void> extractProgressDetails() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    var res = tryParseJwt(jwt);
    String url = "https://spider.nitt.edu/inductions20test/api/announcements";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt}',
    };

    Response response = await get(url, headers: headers);

    int statusCode = response.statusCode;
    if (statusCode == 200) {
      var parsedJson = json.decode(response.body);
      var an = parsedJson["Announcements_no"];
      var date;
      var desc;
      announcements = {};
      for (int i = 0; i < an; i++) {
        date = parsedJson["Announcements"]["$i"]["date_time"];
        desc = parsedJson["Announcements"]["$i"]["description"];
        announcements["$date"] = "$desc";
      }
    }
  }
}
