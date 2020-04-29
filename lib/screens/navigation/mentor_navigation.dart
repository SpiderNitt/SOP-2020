import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inductions_20/screens/mentor/mentor_home.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_list_tile.dart';

import '../../theme/navigation.dart';

class MentorCustomDrawer extends StatelessWidget {
  final String _name;
  final String _username;
  final bool _isDash;
  final bool _isTask;
  final bool _isReview;
  final bool _isGithub;
  final bool _isAnnouncement;
  final storage = new FlutterSecureStorage();

  MentorCustomDrawer(this._name, this._username, this._isDash, this._isTask,
      this._isReview, this._isGithub, this._isAnnouncement);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  _name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: theme.primaryColor,
                  ),
                ),
                accountEmail: Text(
                  _username,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.primaryColor,
                  ),
                ),
                currentAccountPicture: Image(
                  image: AssetImage("assets/images/spiderIcon.png"),
                ),
                decoration: BoxDecoration(
                  color: theme.tertiaryColor,
                ),
              ),
            ),
            CustomListTile(Icons.home, "Home Page", () async {
              if (_isDash == false) {
                String token = await storage.read(key: "jwt");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Mentor(token)),
                    ModalRoute.withName('/mentor'));
              }
            }),
            CustomListTile(Icons.announcement, "Announcements", () {
              if (_isAnnouncement == false) {
                Navigator.of(context).pushNamed('/mentor/announcement');
              }
            }),
            CustomListTile(Icons.pages, "Tasks", () async {
              if (_isTask == false) {
                String token = await storage.read(key: "jwt");
                Navigator.pushNamed(context, '/task',
                    arguments: {'jwt': token});
              }
            }),
            CustomListTile(Icons.rate_review, "Reviews", () async {
              if (_isReview == false) {
                String token = await storage.read(key: "jwt");
                Navigator.pushNamed(context, '/review',
                    arguments: {'jwt': token});
              }
            }),
            CustomListTile(Icons.person_outline, "Change Github", () async {
              if (_isGithub == false) {
                String token = await storage.read(key: "jwt");
                Navigator.pushNamed(context, '/bio', arguments: {'jwt': token});
              }
            }),
            CustomListTile(Icons.exit_to_app, "Logout", () async {
              final storage = new FlutterSecureStorage();
              await storage.delete(key: "jwt");
              await storage.delete(key: "password");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }),
          ],
        ),
      ),
    );
  }
}
