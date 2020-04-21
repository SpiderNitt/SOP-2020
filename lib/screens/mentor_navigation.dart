import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            CustomListTile(Icons.home, "Home Page", () => {}),
            CustomListTile(Icons.rate_review, "Reviews", () => {}),
            CustomListTile(Icons.announcement, "Announcements", () => {}),
            CustomListTile(Icons.person_outline, "Change Github", () => {}),
            CustomListTile(Icons.exit_to_app, "Logout", () => {}),
          ],
        ),
      ),
    );
  }
}
