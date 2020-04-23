import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inductions_20/screens/mentor/mentor_home.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_list_tile.dart';

import '../../theme/navigation.dart';

class MentorCustomDrawer extends StatelessWidget {
  final String _name;
  final String _username;
  // final String _url;
  final storage = new FlutterSecureStorage();

  MentorCustomDrawer(this._name, this._username);

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
              String token = await storage.read(key: "jwt");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mentor(token)),
              );
            }),
            CustomListTile(Icons.pages, "Tasks", () async {
              String token = await storage.read(key: "jwt");
              Navigator.pushNamed(context, '/task', arguments: {'jwt': token});
            }),
            CustomListTile(Icons.rate_review, "Reviews", () async {
              String token = await storage.read(key: "jwt");
              Navigator.pushNamed(context, '/review',
                  arguments: {'jwt': token});
            }),
            CustomListTile(Icons.person_outline, "Change Github", () async {
              String token = await storage.read(key: "jwt");
              Navigator.pushNamed(context, '/bio', arguments: {'jwt': token});
            }),
            CustomListTile(Icons.exit_to_app, "Logout", () async {
              final storage = new FlutterSecureStorage();
              await storage.delete(key: "jwt");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }),
          ],
        ),
      ),
    );
  }
}
