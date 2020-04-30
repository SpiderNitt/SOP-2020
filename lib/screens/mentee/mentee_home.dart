import 'dart:convert' show json;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_box.dart';
import 'config/jwtparse.dart';
import 'config/extractjwt.dart';
import 'package:inductions_20/screens/navigation/mentee_navigation.dart';

import 'package:inductions_20/screens/mentee/data/mentee_profile.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> {
  String username = " ";
  _MyHomePage();
  List<Color> clickcolor = [
    theme.tertiaryColor,
    theme.primaryLightColor,
    theme.primaryLightColor,
    theme.primaryLightColor,
    theme.primaryLightColor,
    theme.primaryLightColor,
    theme.primaryLightColor,
    theme.primaryLightColor,
  ];
  List list = [];
  List task_list = [];
  List profile_no_list = [0, 1, 2, 3];
  List taskno_list = [];
  var currentProfileNo;

  var task = "WEB";
  var user;
  var subscription;

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

    this.user = {
      "name": "loading..",
      "avatar_url":
          "https://media-exp1.licdn.com/dms/image/C510BAQG9qrZT4zZUUA/company-logo_200_200/0?e=2159024400&v=beta&t=nv5kv0k1DSSLrKxY2fLQ4YEsfZGvQ-XJ8Ypiu66RqaA",
      "login": "loading.."
    };
    makeRequest();
  }

  dispose() {
    super.dispose();
    subscription.cancel();
  }

  Future<void> makeRequest() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    var jwt = provideJwt.jwt;

    var res = tryParseJwt(jwt);
    setState(() {
      username = res['github_username'];
    });

    try {
      String url = 'https://api.github.com/users/';
      http.Response response = await http.get(Uri.encodeFull(url + username),
          headers: {"Accept": "application/json"});
      var user1 = await json.decode(response.body);
      setState(() {
        this.user = user1;
      });
    } catch (e) {
      print("exception error: $e");
    }

    try {
      MenteeProfile menteeProfile = MenteeProfile();
      await menteeProfile.extractResponse();
      setState(() {
        this.list = menteeProfile.profilelist;
        this.profile_no_list = menteeProfile.profnolist;
        this.task = list[0];
        this.currentProfileNo = profile_no_list[0];
      });
    } catch (e) {
      print("exception error: $e");
    }

    try {
      Profile_task profileTask = Profile_task(profile_no_list[0]);
      await profileTask.tasks();
      setState(() {
        task_list = profileTask.prof_task_title;
        taskno_list = profileTask.taskno_list;
      });
    } catch (e) {
      print("exception error : $e");
    }
  }

  double profilewidth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 400) {
      profilewidth = 195;
    } else if (width <= 600) {
      profilewidth = 195;
    } else if (width <= 900) {
      profilewidth = 195;
    } else {
      profilewidth = 320;
    }

    return Scaffold(
      backgroundColor: theme.primaryColor,
      drawer: MenteeCustomDrawer(
        '${this.user["name"]}',
        username,
        '${this.user["avatar_url"]}',
        true,
        false,
        false,
      ),
      appBar: AppBar(
        title: Text(
          "DASHBOARD",
        ),
        centerTitle: true,
        backgroundColor: theme.blackColor,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      width: width,
                      height: 40,
                      child: Text(
                        '${this.user["name"]}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: theme.fontColor),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 45),
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              '${this.user["avatar_url"]}'),
                          radius: 90,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 65),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'GitHub:  ',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: theme.fontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${this.user["login"]}',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: theme.tertiaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.12,
                maxChildSize: 0.8,
                builder: (BuildContext c, s) {
                  var boxDecoration = BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  );
                  var container = Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: theme.blackColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(color: theme.fontColor, blurRadius: 2.0)
                      ],
                    ),
                    child: ListView(
                      controller: s,
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 8,
                            width: 50,
                            decoration: boxDecoration,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 80,
                          width: 370,
                          color: theme.blackColor,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              for (int i = 0; i < list.length; i++)
                                CustomBox(list[i], () async {
                                  setState(
                                    () {
                                      for (int j = 0; j < list.length; j++) {
                                        if (j == i)
                                          clickcolor[j] = theme.tertiaryColor;
                                        else
                                          clickcolor[j] =
                                              theme.primaryLightColor;
                                      }
                                      task = list[i];
                                      currentProfileNo = profile_no_list[i];
                                    },
                                  );

                                  Profile_task profileTask =
                                      Profile_task(profile_no_list[i]);
                                  await profileTask.tasks();
                                  setState(
                                    () {
                                      task_list = profileTask.prof_task_title;
                                      taskno_list = profileTask.taskno_list;
                                    },
                                  );
                                }, profilewidth, 100, 12, clickcolor[i], 20, 3,
                                    10),
                            ],
                          ),
                        ),
                        new Divider(
                          color: theme.fontColor,
                          height: 50,
                          thickness: 3,
                        ),
                        for (int i = 0; i < task_list.length; i++)
                          CustomBox(task_list[i], () {
                            print(taskno_list[i]);
                            List a = [
                              task,
                              taskno_list[i],
                              this.user,
                              currentProfileNo
                            ];
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Task(task: a),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var animate = Tween<Offset>(
                                    end: const Offset(1.0, 0.0),
                                    begin: Offset.zero,
                                  ).animate(secondaryAnimation);
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(1.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: SlideTransition(
                                      position: animate,
                                      child: child,
                                    ),
                                  );
                                },
                              ),
                            );
                          }, 320, 60, 15, theme.secondaryColor, 20, 3, 10),
                      ],
                    ),
                  );
                  return container;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
