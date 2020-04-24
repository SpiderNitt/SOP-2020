import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        ListView,
        MediaQuery,
        Scaffold,
        ScrollController,
        SingleTickerProviderStateMixin,
        State,
        StatefulWidget,
        Text,
        Widget;
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/widgets/Announcementbox.dart';
import 'package:inductions_20/screens/mentee/data/announcement.dart';
import 'package:inductions_20/screens/navigation/mentee_navigation.dart';

import 'config/jwtparse.dart';
import 'config/extractjwt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Announcement extends StatefulWidget {
  Announcement();
  @override
  AnnouncementState createState() => AnnouncementState();
}

class AnnouncementState extends State<Announcement>
    with SingleTickerProviderStateMixin {
  var username;
  var name;
  var url;
  var user = {"name": "loading..", "avatar_url": " ", "login": "loading.."};
  List _messages = [];
  List date = [];
  List time = [];

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    this.user = {
      "name": "loading..",
      "avatar_url":
          "https://media-exp1.licdn.com/dms/image/C510BAQG9qrZT4zZUUA/company-logo_200_200/0?e=2159024400&v=beta&t=nv5kv0k1DSSLrKxY2fLQ4YEsfZGvQ-XJ8Ypiu66RqaA",
      "login": "loading.."
    };
    get_announcement();
  }

  Future<String> get_announcement() async {
    AnnouncementList announcement_list = AnnouncementList();
    await announcement_list.extractProgressDetails();

    var msg = [];
    var _date = [];
    var _time = [];
    announcement_list.announcements.forEach((k, v) {
      msg.add("$v");
      String date1 = "$k".substring(0, 10);

      int hr = int.parse("$k".substring(11, 13)) + 5;
      int min = int.parse("$k".substring(14, 16)) + 30;
      int sec = int.parse("$k".substring(17, 19));
      if (min >= 60) {
        hr++;
        min = min - 60;
      }
      _date.add(date1);
      _time.add("$hr:$min:$sec");
    });
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    var jwt = provideJwt.jwt;
    var res = tryParseJwt(jwt);

    username = res['github_username'];

    String url = 'https://api.github.com/users/';
    http.Response response = await http.get(Uri.encodeFull(url + username),
        headers: {"Accept": "application/json"});
    var user1 = await json.decode(response.body);
    setState(() {
      this.user = user1;
      this._messages = msg;
      this.time = _time;
      this.date = _date;
    });
  }

  double commentwidth;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 400) {
      commentwidth = 210;
    } else if (width <= 600) {
      commentwidth = 230;
    } else if (width <= 900) {
      commentwidth = 290;
    } else {
      commentwidth = 390;
    }

    return Scaffold(
      backgroundColor: theme.primaryColor,
      drawer: MenteeCustomDrawer(
          '${this.user["name"]}', username, '${this.user["avatar_url"]}'),
      appBar: AppBar(
        title: Text('''Announcements'''),
        backgroundColor: theme.blackColor,
      ),
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < _messages.length; i++)
            Announcementbox('''Spider''', '''${date[i]}''', '''${time[i]}''',
                '''${_messages[i]}''', width),
        ],
      ),
    );
  }

  State<StatefulWidget> createState() => null;
}
