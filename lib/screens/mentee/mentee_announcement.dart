import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/widgets/Announcementbox.dart';
import 'package:inductions_20/screens/mentee/data/announcement.dart';
import 'package:inductions_20/screens/navigation/mentee_navigation.dart';
import 'package:inductions_20/screens/mentee/data/model/firebaseMessage.dart';
import 'config/jwtparse.dart';
import 'config/extractjwt.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MenteeAnnouncement extends StatefulWidget {
  @override
  AnnouncementState createState() => AnnouncementState();
}

class AnnouncementState extends State<MenteeAnnouncement>
    with SingleTickerProviderStateMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  var username;
  var name;
  var url;
  var gitacc;
  var menteeName;
  var user;
  List _messages = [];
  List date = [];
  List time = [];
  var subscription;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        AlertDialog alert = AlertDialog(
          title: Text("Spider Orientation"),
          content:
              Text("No internet connection. Reconnect and reopen the app."),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop('dialog');
                SystemNavigator.pop();
              },
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    });

    scrollController = ScrollController();
    this.user = {
      "name": "loading..",
      "avatar_url":
          "https://media-exp1.licdn.com/dms/image/C510BAQG9qrZT4zZUUA/company-logo_200_200/0?e=2159024400&v=beta&t=nv5kv0k1DSSLrKxY2fLQ4YEsfZGvQ-XJ8Ypiu66RqaA",
      "login": "loading.."
    };
    getAnnouncement();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  dispose() {
    super.dispose();
    subscription.cancel();
  }

  Future<void> getAnnouncement() async {
    AnnouncementList announcementList = AnnouncementList();
    await announcementList.extractProgressDetails();

    var msg = [];
    var _date = [];
    var _time = [];
    announcementList.announcements.forEach((k, v) {
      msg.add("$v");
      String date1 = "$k".substring(0, 10);

      int hr = int.parse("$k".substring(11, 13));
      int min = int.parse("$k".substring(14, 16));

      _date.add(date1);
      _time.add("$hr:$min");
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
        '${this.user["name"]}',
        username,
        '${this.user["avatar_url"]}',
        false,
        true,
        false,
      ),
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
