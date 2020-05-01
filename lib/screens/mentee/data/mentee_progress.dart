import 'package:inductions_20/screens/mentee/config/extractjwt.dart';
import 'package:inductions_20/screens/mentee/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MenteeProgress {
  int taskNo;
  int basicPer;
  int advancePer;
  List submittedLinks;
  Map previousFeedbacks;
  var recentFeedback;

  MenteeProgress(this.taskNo);

  Future<void> extractProgressDetails() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    var res = tryParseJwt(jwt);
    var rollno = res["roll"];
    try {
      String url =
          "https://spider.nitt.edu/inductions20test/api/mentee/$rollno/task/${this.taskNo}/progress";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      };
      Response response = await get(url, headers: headers);
      recentFeedback = "5:30";
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        var parsedJson = json.decode(response.body);
        int subNo = parsedJson["submissions_no"];
        subNo = subNo - 1;
        var submissions = parsedJson["submissions"];
        this.basicPer = submissions["$subNo"]["basic_task_percent"];
        this.advancePer = submissions["$subNo"]["advanced_task_percent"];
        int noLinks = submissions["$subNo"]["submission_links_no"];
        previousFeedbacks = {};
        var submlinks = submissions["$subNo"]["submission_links"];
        var submissionLinks = jsonDecode(submlinks);

        submittedLinks = [];
        for (int i = 0; i < noLinks; i++) {
          submittedLinks.add(submissionLinks["$i"]);
        }

        var feedTime = "5:30";
        for (int i = 0; i <= subNo; i++) {
          if (submissions["$i"]["is_reviewed"] == true) {
            feedTime = submissions["$i"]["feedback_date_time"];
            this.previousFeedbacks["$feedTime"] = submissions["$i"]["feedback"];
            this.basicPer = submissions["$i"]["basic_task_percent"];
            this.advancePer = submissions["$i"]["advanced_task_percent"];
          }
        }

        this.recentFeedback = feedTime;
      } else {
        print("failed to load");
      }
    } catch (e) {
      basicPer = 0;
      advancePer = 0;
      submittedLinks = [];
      previousFeedbacks = {};
      recentFeedback = "5:30";
    }
  }
}
