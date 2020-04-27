import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_list_tile.dart';
import '../../theme/navigation.dart';


class MenteeCustomDrawer extends StatelessWidget {
  final String _name;
  final String _username;
  final String _url;
  final storage = new FlutterSecureStorage();

  MenteeCustomDrawer(this._name, this._username, this._url);

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
            CustomListTile(Icons.home, "Home Page", () {
              print("home");
              Navigator.pushNamed(context, '/mentee/');
            }),
            CustomListTile(Icons.announcement, "Announcements", () {
              print("Announcement");
              Navigator.pushNamed(context, '/mentee/announcement/');
            }),
              CustomListTile(Icons.person_outline, "Change_GitHub", () async{
              print("Change_github");
              String token = await storage.read(key: "jwt");
              Navigator.pushNamed(context, '/biomentee', arguments: {'jwt': token});
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
