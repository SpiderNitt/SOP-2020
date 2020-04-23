import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:inductions_20/screens/widgets/custom_list_tile.dart';
import 'package:inductions_20/theme/styling.dart';

class MentorCustomDrawer extends StatelessWidget {
  final String _name;
  final String _username;
  final String _url;

  MentorCustomDrawer(this._name, this._username, this._url);

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
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    _url,
                  ),
                  backgroundColor: theme.fontColor,
                ),
                decoration: BoxDecoration(
                  color: theme.tertiaryColor,
                ),
              ),
            ),
            CustomListTile(Icons.home, "Home Page", () async {
              final storage = new FlutterSecureStorage();
              String token = await storage.read(key: "jwt");
              Navigator.pushNamed(context, '/', arguments: {'jwt': "$token"});
            }),
            CustomListTile(Icons.rate_review, "Reviews", () {
              Navigator.pushNamed(context, '/reviews');
            }),
            CustomListTile(Icons.person_outline, "Change Github", () {
              Navigator.pushNamed(context, '/bio');
            }),
            CustomListTile(Icons.exit_to_app, "Logout", () async {
              final storage = new FlutterSecureStorage();
              await storage.delete(key: "jwt");
              Navigator.pushNamed(context, '/login');
            }),
          ],
        ),
      ),
    );
  }
}
