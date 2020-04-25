import 'package:inductions_20/theme/mentee.dart';
import 'package:flutter/material.dart';
import 'package:inductions_20/screens/mentee/widgets/custom_comment.dart';

class TASKfeedback extends StatefulWidget {
  Map feedback;
  var taskname;
  var mentorname;

  TASKfeedback(this.feedback, this.taskname, this.mentorname);

  TASKfeedbackState createState() =>
      TASKfeedbackState(feedback, taskname, mentorname);
}

class TASKfeedbackState extends State<TASKfeedback>
    with SingleTickerProviderStateMixin {
  var taskdes;

  var taskname;
  Map feedback;
  var mentorname;
  TASKfeedbackState(this.feedback, this.taskname, this.mentorname);
  List _messages = [];
  List date = [];
  List time = [];
  TextEditingController textEditingController;
  ScrollController scrollController;

  bool enableButton = false;
  @override
  void initState() {
    feedback.forEach((k, v) {
      _messages.add("$v");
      String date1 = "$k".substring(0, 10);

      int hr = int.parse("$k".substring(11, 13));
      int min = int.parse("$k".substring(14, 16));
      int sec = int.parse("$k".substring(17, 19));

      date.add(date1);
      time.add("$hr:$min");
    });

    textEditingController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          title: Text('${taskname}'),
          backgroundColor: theme.blackColor,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var avatar = Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 8.0, right: 8.0),
                    child: CircleAvatar(
                      child: Text("${mentorname[0]}"),
                    ),
                  );

                  var triangle = CustomPaint(
                    painter: Triangle(),
                  );

                  var messagebody = Comment_box(
                      _messages[index],
                      theme.tertiaryColor,
                      theme.blackColor,
                      commentwidth,
                      '''$mentorname''',
                      date[index],
                      time[index]);
                  Widget message;

                  message = Stack(
                    children: <Widget>[
                      Positioned(left: 0, bottom: 0, child: triangle),
                      messagebody,
                    ],
                  );

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      avatar,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: message,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  State<StatefulWidget> createState() => null;
}
