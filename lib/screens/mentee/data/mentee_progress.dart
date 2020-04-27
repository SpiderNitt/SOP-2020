import 'package:inductions_20/screens/mentee/config/extractjwt.dart';
import 'package:inductions_20/screens/mentee/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Mentee_progress {
  int task_no;
  int basic_per;
  int advance_per;
  List submitted_links;
  Map previous_feedbacks;
  var recent_feedback;

  Mentee_progress(this.task_no);

  Future<void> extractProgressDetails() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    var res = tryParseJwt(jwt);
    var rollno = res["roll"];
    try {
      String url =
          "https://spider.nitt.edu/inductions20test/api/mentee/$rollno/task/${this.task_no}/progress";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      };
      Response response = await get(url, headers: headers);
      recent_feedback = "5:30";
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        var parsedJson = json.decode(response.body);
        int sub_no = parsedJson["submissions_no"];
        sub_no = sub_no - 1;
        var submissions = parsedJson["submissions"];
        this.basic_per = submissions["$sub_no"]["basic_task_percent"];
        this.advance_per = submissions["$sub_no"]["advanced_task_percent"];
        int no_links = submissions["$sub_no"]["submission_links_no"];
        Map submission_links = {};
        previous_feedbacks = {};
        var submlinks = submissions["$sub_no"]["submission_links"];
        submission_links = jsonDecode(submlinks);

        submitted_links = [];
        for (int i = 0; i < no_links; i++) {
          submitted_links.add(submission_links["$i"]);
        }

        var feed_time = "5:30";
        for (int i = 0; i <= sub_no; i++) {
          if (submissions["$i"]["is_reviewed"] == true) {
            feed_time = submissions["$i"]["feedback_date_time"];
            this.previous_feedbacks["${feed_time}"] =
                submissions["$i"]["feedback"];
            this.basic_per = submissions["$i"]["basic_task_percent"];
            this.advance_per = submissions["$i"]["advanced_task_percent"];
          }
        }

        this.recent_feedback = feed_time;
      } else {
        print("failed to load");
      }
    } catch (e) {
      basic_per = 0;
      advance_per = 0;
      submitted_links = [];
      previous_feedbacks = {};
      recent_feedback = "5:30";
    }
  }
}
