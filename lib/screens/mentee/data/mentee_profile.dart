import 'package:inductions_20/screens/mentee/config/extractjwt.dart';
import 'package:inductions_20/screens/mentee/config/jwtparse.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MenteeProfile {
  List profilelist;
  List profnolist;
  MenteeProfile();

  Future<void> extractResponse() async {
    List _profiles = [
      'Algos',
      'App Development - Android Native',
      'App Development - Flutter',
      'App Development - React Native',
      'Tronix - Embedded Systems and Analog Electronics',
      'Tronix - Robotics and control',
      'Tronix - Signal Processing and Machine Learning',
      'Web Development'
    ];

    profnolist = [];
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    var res = tryParseJwt(jwt);

    var rollno = res["roll"];
    print(rollno);
    String url =
        "https://spider.nitt.edu/inductions20test/api/mentee/$rollno/profile";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    Response response = await get(url, headers: headers);

    int statusCode = response.statusCode;
    if (statusCode == 200) {
      var parsedJson = json.decode(response.body);

      var profids = parsedJson["profile_ids"];
      List proflist = [];
      int profIdNo = parsedJson["profiles_ids_no"];
      for (int i = 0; i < profIdNo; i++) {
        proflist.add(_profiles[profids["$i"] - 1]);
        this.profnolist.add(profids["$i"]);
      }
      this.profilelist = proflist;
    } else {
      print("failed to load");
    }
  }
}

class ProfileTask {
  int profno;
  String mentorName;
  String mentorContact;

  List profTaskTitle;
  List tasknoList;

  ProfileTask(this.profno);

  Future<void> tasks() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    String url = "https://spider.nitt.edu/inductions20test/api/profile/$profno";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    Response response = await get(url, headers: headers);
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      var parsedJson = json.decode(response.body);
      var _tasks = parsedJson["tasks"];

      List returnTask = [];
      List taskNoList = [];
      int taskNo = parsedJson["tasks_no"];
      for (int i = 0; i < taskNo; i++) {
        returnTask.add(_tasks["$i"]["task_title"]);
        taskNoList.add(_tasks["$i"]["task_id"]);
      }
      this.profTaskTitle = returnTask;
      this.tasknoList = taskNoList;
    } else {
      print("failed to load");
    }
  }
}

class MentorDetails {
  int profno;
  String mentorName;
  String mentorContact;

  MentorDetails(this.profno);

  Future<void> mentorExtract() async {
    ProvideJwt provideJwt = ProvideJwt();

    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    var res = tryParseJwt(jwt);
    var rollno = res["roll"];
    String url =
        "https://spider.nitt.edu/inductions20test/api/mentee/$rollno/profile/$profno";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    Response response = await get(url, headers: headers);
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      var parsedJson = json.decode(response.body);
      this.mentorContact = parsedJson["mentor_contact"];
      this.mentorName = parsedJson["mentor_name"];
    } else {
      print("failed to load");
    }
  }
}
