import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inductions_20/screens/widgets/custom_list_tile.dart';

class MenteeCustomDrawer extends StatelessWidget {
  final String _name;
  final String _username;
  final String _url;

  MenteeCustomDrawer(this._name, this._username, this._url);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF00171f),
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
                    color: Color(0xFF00171f),
                  ),
                ),
                accountEmail: Text(
                  _username,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF00171f),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    _url,
                  ),
                  backgroundColor: Color(0xFFFFFFFF),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF00A8E8),
                ),
              ),
            ),
            CustomListTile(Icons.home, "Home Page", () => {}),
            CustomListTile(Icons.announcement, "Announcements", () => {}),
            CustomListTile(Icons.exit_to_app, "Logout", () => {}),
          ],
        ),
      ),
    );
  }
}
