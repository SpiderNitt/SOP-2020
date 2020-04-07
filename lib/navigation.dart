import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomDrawer extends StatelessWidget {
  String name;
  String username;
  String url;

  CustomDrawer(this.name, this.username, this.url);

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
              height: 200.0,
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF00171f),
                  ),
                ),
                accountEmail: Text(
                  username,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF00171f),
                  ),
                ),
                currentAccountPicture: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        url,
                      ),
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF00A8E8),
                ),
              ),
            ),
            CustomListTile(Icons.person, "Profile", () => {}),
            CustomListTile(Icons.person_outline, "Mentor", () => {}),
            CustomListTile(Icons.rate_review, "Review", () => {}),
            CustomListTile(Icons.exit_to_app, "Logout", () => {}),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF00171f),
      child: InkWell(
        onTap: () {},
        focusColor: Color(0xFF00171f),
        highlightColor: Color(0xFF00171f),
        splashColor: Color(0xFF00A8E8).withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon, color: Color(0xFF00A8E8)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right, color: Color(0xFF00A8E8)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
