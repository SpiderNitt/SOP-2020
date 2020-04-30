import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:io';
import 'package:inductions_20/screens/mentee/data/task_description.dart';
import 'package:inductions_20/screens/mentee/data/mentee_profile.dart';
import 'package:inductions_20/screens/mentee/data/comments.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_graph.dart';
import 'package:inductions_20/screens/mentee/mentee_home.dart';
import 'package:inductions_20/screens/mentee/feedbacks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_comment.dart';
import 'package:inductions_20/screens/mentee/task_description.dart';
import 'package:inductions_20/screens/mentee/comments.dart';
import 'package:inductions_20/screens/mentee/data/mentee_progress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'config/jwtparse.dart';
import 'config/extractjwt.dart';
import 'package:http/http.dart';

class Task extends StatefulWidget {
  final List task;
  Task({this.task});

  TaskState createState() => TaskState(task);
}

class TaskState extends State<Task> with SingleTickerProviderStateMixin {
  var taskdes = "loading...";
  List resDesc = [];
  List resLink = [];

  var submitbarcolor = theme.fontColor;
  var user;
  var basicPer = 0.0;
  var advancePer = 0.0;
  var overallPer;
  var decoverallPer;
  var subCount = 0;
  List task;
  var decbasicPer;
  var decadvancePer;
  var decbasicBarper;
  var decadvanceBarper;
  var feedTime = "5:30";
  var recentTime;
  var recentDate;
  Map feedbacks = {};
  List taskSubmitted = [];
  var commentsLength = 0;
  var mentorname = " ";
  var mentorcontact = "loading..";
  int hr = 0, min = 0, sec = 0;
  TextEditingController textEditingController, textEditingController1;

  final storage = FlutterSecureStorage();
  TaskState(this.task);

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Description'),
    Tab(text: 'Progress'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    print(task);

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    )..addListener(() {
        setState(() {
          if (_tabController.index == 1)
            submitbarcolor = theme.tertiaryColor;
          else
            submitbarcolor = theme.fontColor;
        });
      });
    this.myTabs = <Tab>[
      Tab(text: 'Description'),
      Tab(text: 'Progress'),
    ];
    textEditingController = TextEditingController();
    textEditingController1 = TextEditingController();
    this.overallPer = (this.basicPer * 0.3) + (this.advancePer * 0.7);
    this.decoverallPer = this.overallPer * 100;
    decbasicPer = this.basicPer * 100;
    decadvancePer = this.advancePer * 100;
    subCount = 0;
    commentsLength = 0;
    taskSubmitted = [];
    feedbacks = {};
    feedTime = "5:30";
    taskDesc();
  }

  Future<void> taskDesc() async {
    Task_details taskDetails = Task_details(task[1]);
    await taskDetails.extractTaskDetails();
    setState(() {
      this.taskdes = taskDetails.task_description;
      this.resDesc = taskDetails.task_resources_desc;
      this.resLink = taskDetails.task_resources_link;
      this.subCount = taskDetails.no_submissions;
    });

    Mentee_progress menteeProgress = Mentee_progress(task[1]);

    await menteeProgress.extractProgressDetails();

    setState(() {
      basicPer = menteeProgress.basic_per / 100;
      advancePer = menteeProgress.advance_per / 100;

      feedTime = menteeProgress.recent_feedback;
      feedbacks = menteeProgress.previous_feedbacks;

      print("check");
      if (feedTime != "5:30") {
        String date = feedTime.substring(0, 10);
        hr = int.parse(feedTime.substring(11, 13));
        min = int.parse(feedTime.substring(14, 16));
        sec = int.parse(feedTime.substring(17, 19));

        this.recentDate = date;

        this.recentTime = "$hr:$min";
      } else {}
      this.taskSubmitted = menteeProgress.submitted_links;
      this.overallPer = (this.basicPer * 0.7) + (this.advancePer * 0.3);
      this.decoverallPer = this.overallPer * 100;
      decbasicPer = this.basicPer * 100;
      decadvancePer = this.advancePer * 100;
    });

    Mentor_details mentorDetails = Mentor_details(task[3]);
    await mentorDetails.mentor_extract();

    setState(() {
      this.mentorname = mentorDetails.mentor_name;
      this.mentorcontact = mentorDetails.mentor_contact;
    });

    CommentsList commentsList1 = CommentsList(task[1]);
    await commentsList1.extractComment();
    setState(() {
      commentsLength = commentsList1.comments.length;
    });
  }

  Future<int> notify() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    Response res = await get(
        'https://spider.nitt.edu/inductions20test/api/task/${task[1]}',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $jwt'});
    dynamic resmap = jsonDecode(res.body);
    dynamic rescomm = await storage.read(key: '${task[1]}_comments');

    if (rescomm == null) {
      return resmap['comments'].length;
    } else {
      return resmap['comments'].length - int.tryParse(rescomm);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double bottombarwidth;
  double submitedlinkswidth;
  double commentwidth;
  double submissionwidth;
  double percentbarwidth;
  double linkinputwidth;
  double previousfeedbackwidth;
  double reviewpadding;
  double leftpaddingwidth;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 350) {
      submitedlinkswidth = 4 * (width / 5);
      submissionwidth = 110;
      commentwidth = 3 * (width / 4);
      reviewpadding = 10;
      linkinputwidth = 370;
      bottombarwidth = 105;
      percentbarwidth = 120;
      leftpaddingwidth = 5;
      previousfeedbackwidth = 320;
      decbasicBarper = this.basicPer * percentbarwidth;
      decadvanceBarper = this.advancePer * percentbarwidth;
    } else if (width <= 600) {
      submitedlinkswidth = 4 * (width / 5);
      submissionwidth = 110;
      commentwidth = 3 * (width / 4);
      linkinputwidth = 370;
      leftpaddingwidth = 25;
      reviewpadding = 10;
      previousfeedbackwidth = 320;
      bottombarwidth = width / 3;
      percentbarwidth = 130;
      decbasicBarper = this.basicPer * percentbarwidth;
      decadvanceBarper = this.advancePer * percentbarwidth;
    } else if (width <= 900) {
      submitedlinkswidth = 4 * (width / 5);
      submissionwidth = 110;
      commentwidth = 3 * (width / 4);
      bottombarwidth = width / 3;
      leftpaddingwidth = 25;
      linkinputwidth = 370;
      reviewpadding = 10;
      previousfeedbackwidth = 320;
      percentbarwidth = 130;
      decbasicBarper = this.basicPer * percentbarwidth;
      decadvanceBarper = this.advancePer * percentbarwidth;
    } else {
      submitedlinkswidth = 4 * (width / 5);
      submissionwidth = 110;
      commentwidth = 390;
      leftpaddingwidth = 180;
      bottombarwidth = 430;
      percentbarwidth = 600;
      linkinputwidth = 500;
      reviewpadding = 340;
      previousfeedbackwidth = 400;
      decbasicBarper = this.basicPer * percentbarwidth;
      decadvanceBarper = this.advancePer * percentbarwidth;
    }
    task = widget.task;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          title: Text('${task[0]}'),
          backgroundColor: theme.blackColor,
          bottom: TabBar(controller: _tabController, tabs: myTabs),
        ),
        floatingActionButton: _tabController.index == 0
            ? FloatingActionButton(
                onPressed: () {},
                backgroundColor: theme.fontColor,
                child: ListView(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                  ),
                  CircularPercentage(
                      48,
                      8,
                      this.overallPer,
                      Text("${decoverallPer.toStringAsFixed(0)}"),
                      theme.advancetaskColor),
                ]))
            : null,
        bottomNavigationBar: Container(
          height: 50,
          width: 370,
          child: Material(
            color: theme.blackColor,
            elevation: 10.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 1),
                      width: bottombarwidth,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 16, left: leftpaddingwidth, right: 0),
                                child: Text("$subCount submission",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.tertiaryColor,
                                    ))),
                          ])),
                  FutureBuilder(
                      future: notify(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Stack(
                            children: <Widget>[
                              CustomBox('Discussion', () {
                                List a = task;
                                storage.write(
                                    key: '${task[1]}_comments',
                                    value: '$commentsLength');
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            TaskComment(task: a),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(0.0, 1.0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: SlideTransition(
                                              position: Tween<Offset>(
                                                end: const Offset(0.0, 1.0),
                                                begin: Offset.zero,
                                              ).animate(secondaryAnimation),
                                              child: child,
                                            ),
                                          );
                                        }));
                              }, bottombarwidth, 50, 15, theme.blackColor, 15,
                                  0, 0),
                              if (snapshot.data != 0)
                                Positioned(
                                  right: 9,
                                  top: 9,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 14,
                                      minHeight: 14,
                                    ),
                                    child: Text(
                                      '${snapshot.data}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            '${snapshot.error}',
                            style: TextStyle(color: Colors.white),
                          );
                        } else
                          return CircularProgressIndicator();
                      }),
                ]),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: myTabs.map((Tab tab) {
            final String label = tab.text.toLowerCase();
            if (label != 'progress')
              return TaskDescription(theme.primaryColor, taskdes, resLink,
                  resDesc, mentorname, mentorcontact);
            else {
              return ListView(children: <Widget>[
                Container(
                  width: previousfeedbackwidth,
                  margin: EdgeInsets.all(10),
                  child: Material(
                    color: theme.blackColor,
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              ''' After adding the links, review of the work will be requested only on clicking the review button. you can also add a comment with the request.''',
                              style: TextStyle(
                                  color: theme.tertiaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.only(left: 18.0),
                          width: linkinputwidth,
                          decoration: BoxDecoration(
                              color: theme.secondaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: theme.fontColor,
                            ),
                            decoration: InputDecoration.collapsed(
                                hintText: "Submit the Link of the task",
                                hintStyle: (TextStyle(color: Colors.white24)),
                                fillColor: theme.fontColor),
                            controller: textEditingController,
                          ),
                        ),
                        CustomBox('Add link', () async {
                          print(taskSubmitted.length);
                          var text = textEditingController.value.text;
                          if (taskSubmitted.length >= 5) {
                            showAlertDialog(
                                context, "submitted links limited upto 5");
                          } else {
                            try {
                              textEditingController.clear();

                              setState(() {
                                taskSubmitted.add(text);
                              });
                            } catch (e) {
                              showAlertDialog(context, "Invalid link");
                            }
                          }
                        }, 110, 38, 14, theme.tertiaryColor, 10, 0, 10),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "Submitted Links:",
                                          style: TextStyle(
                                              color: theme.fontColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ]),
                              for (int i = 0; i < taskSubmitted.length; i++)
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CustomBox('''${taskSubmitted[i]}''', () {
                                        launch('${taskSubmitted[i]}');
                                      }, submitedlinkswidth, 38, 15,
                                          theme.primaryLightColor, 10, 3, 0),
                                      IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: theme.fontColor,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            taskSubmitted
                                                .remove(taskSubmitted[i]);
                                          });
                                        },
                                      ),
                                    ]),
                            ],
                          ),
                        )
                      ],
                    )),
                new Divider(
                  color: theme.fontColor,
                  height: 50,
                  thickness: 1,
                ),
                if (feedTime != "5:30")
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, bottom: 8.0, right: 8.0),
                      child: CircleAvatar(
                        child: Text("${mentorname[0]}"),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: CustomPaint(
                          painter: Triangle(theme.tertiaryColor),
                        )),
                    Comment_box(
                        '''${feedbacks[feedTime]}''',
                        theme.tertiaryColor,
                        theme.fontColor,
                        commentwidth,
                        '''$mentorname''',
                        '''$recentDate''',
                        '''$recentTime'''),
                  ]),
                CustomBox('Previous feedbacks', () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  TASKfeedback(feedbacks, task[0], mentorname),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 1.0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  end: const Offset(0.0, 1.0),
                                  begin: Offset.zero,
                                ).animate(secondaryAnimation),
                                child: child,
                              ),
                            );
                          }));
                }, previousfeedbackwidth, 50, 14.5, theme.blackColor, 15, 10,
                    5),
                Container(
                    margin: EdgeInsets.only(
                        top: 30.0, left: reviewpadding, right: reviewpadding),
                    padding: const EdgeInsets.all(20.0),
                    color: theme.blackColor,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.fontColor),
                          decoration: InputDecoration(
                              hintText: 'add a comment with the request',
                              hintStyle: TextStyle(
                                  color: theme.fontColor, fontSize: 15)),
                          controller: textEditingController1,
                        ),
                        CustomBox('Send Request to Review', () async {
                          if (taskSubmitted.length > 0) {
                            try {
                              var text = textEditingController1.value.text;
                              ProvideJwt provideJwt = ProvideJwt();
                              await provideJwt.extractjwt();
                              String jwt = provideJwt.jwt;
                              var res = tryParseJwt(jwt);
                              var rollno = res["roll"];

                              String url =
                                  "https://spider.nitt.edu/inductions20test/api/mentee/new_task_submission";
                              Map<String, String> headers = {
                                'Content-Type': 'application/json',
                                'Accept': 'application/json',
                                'Authorization': 'Bearer $jwt',
                              };
                              Map<String, String> list1 = {};
                              for (int i = 0; i < taskSubmitted.length; i++)
                                list1["$i"] = "${taskSubmitted[i]}";

                              var sublinks = (jsonEncode(list1));
                              print(sublinks);

                              var Json1 = jsonEncode({
                                "rollno": "$rollno",
                                "task_id": task[1],
                                "profile_id": task[3],
                                "submission_links_no": taskSubmitted.length,
                                "submission_links": sublinks,
                                "submission_description": "$text"
                              });

                              Response response = await post(url,
                                  headers: headers, body: Json1);
                              int statusCode = response.statusCode;

                              if (statusCode == 200) {
                                showAlertDialog(context, "Submitted");
                              } else if (statusCode == 400) {
                                showAlertDialog(context, "bad request");
                              } else {
                                showAlertDialog(context, "Server error");
                              }
                            } catch (e) {
                              print("error: $e");
                            }
                          } else
                            showAlertDialog(
                                context, "Add links to request for review");
                        }, 420, 50, 14.5, theme.tertiaryColor, 15, 8, 10),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                ),
                CircularPercentage(
                    180.0,
                    15.0,
                    this.advancePer,
                    CircularPercentage(
                        130.0,
                        15.0,
                        this.basicPer,
                        Text(
                          "${decoverallPer.toStringAsFixed(0)} %",
                          style: TextStyle(color: theme.fontColor),
                        ),
                        theme.tertiaryColor),
                    theme.advancetaskColor),
                Container(
                    margin: const EdgeInsets.only(
                        bottom: 20, top: 20, left: 10, right: 10),
                    padding: const EdgeInsets.all(20.0),
                    color: theme.blackColor,
                    child: Table(children: [
                      TableRow(children: <Widget>[
                        Padding(
                            padding:
                                const EdgeInsets.only(bottom: 15.0, top: 2),
                            child: Text(
                              "Completion",
                              style: TextStyle(
                                  color: theme.fontColor,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding:
                                const EdgeInsets.only(bottom: 15.0, top: 2),
                            child: Text(" ")),
                      ]),
                      TableRow(children: <Widget>[
                        Row(children: <Widget>[
                          Container(
                            width: decbasicBarper,
                            height: 15,
                            color: theme.tertiaryColor,
                          ),
                        ]),
                        Container(
                          width: percentbarwidth,
                          height: 40,
                          padding: const EdgeInsets.only(top: 0, left: 10),
                          child: Text(
                            'Basic Task : $decbasicPer %',
                            style: TextStyle(
                              color: theme.fontColor,
                            ),
                          ),
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Row(children: <Widget>[
                          Container(
                            width: decadvanceBarper,
                            height: 15,
                            color: theme.advancetaskColor,
                          )
                        ]),
                        Container(
                          width: percentbarwidth,
                          height: 40,
                          padding: const EdgeInsets.only(top: 0, left: 10),
                          child: Text(
                            'Advance Task : $decadvancePer %',
                            style: TextStyle(
                              color: theme.fontColor,
                            ),
                          ),
                        )
                      ])
                    ])),
                Container(
                  width: 370,
                  child: Material(
                    color: theme.blackColor,
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              "The Completion percentage Displayed above is calculated as 70% Basic task and 30% Advance task :)",
                              style: TextStyle(
                                  color: theme.tertiaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ),
              ]);
            }
          }).toList(),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, text) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(text),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  State<StatefulWidget> createState() => null;
}
