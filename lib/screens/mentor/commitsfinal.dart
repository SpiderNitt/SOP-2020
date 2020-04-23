import 'package:flutter/material.dart';
import 'package:inductions_20/others/jwtparse.dart';
import 'package:inductions_20/screens/navigation/mentor_navigation.dart';
import 'widgets/commits.dart';
import 'widgets/mentor_details.dart';
import '../../theme/mentor.dart';

class CommitsFinal extends StatefulWidget {
  @override
  _CommitsFinal createState() => _CommitsFinal();
}

class _CommitsFinal extends State<CommitsFinal> {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      drawer: MentorCustomDrawer(tryParseJwt(data['jwt'])['username'],
          tryParseJwt(data['jwt'])['github_username']),
      backgroundColor: config.bgColor,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: config.appbarcolor,
        title: Text('Mentee task'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          MenDet(data['menteename'], data['git_acc']),
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text('Commit History for ${data['repo_det']}',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: config.fontFamily,
                      color: config.fontColor)),
            ),
          ),
          Commits(data['repo_det'], data['git_acc']),
          SizedBox(height: 20),
        ]),
      ),
    );
  }
}
