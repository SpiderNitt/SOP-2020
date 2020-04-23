import 'package:flutter/material.dart';
import '../../../theme/mentor.dart';

class NavigationBar extends StatefulWidget {
  final int value;
  final String jwt;

  NavigationBar(this.value, this.jwt);

  @override
  _NavigationBarState createState() =>
      _NavigationBarState(this.value, this.jwt);
}

class _NavigationBarState extends State<NavigationBar> {
  int currindex = 0;
  String jwt;

  _NavigationBarState(this.currindex, this.jwt);
  // pass this to review page

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            // color: config.bgColor,
            ),
        child: BottomNavigationBar(
          backgroundColor: config.bgColor,
          selectedItemColor: config.fontColor,
          unselectedItemColor: config.fontColor,
          currentIndex: this.currindex,
          selectedFontSize: 18,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: config.fontFamily,
                        color: config.fontColor))),
            BottomNavigationBarItem(
                icon: Icon(Icons.pages),
                title: Text('Reviews',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: config.fontFamily,
                        color: config.fontColor))),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Git',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: config.fontFamily,
                        color: config.fontColor))),
            BottomNavigationBarItem(
                icon: Icon(Icons.event),
                title: Text('Task',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: config.fontFamily,
                        color: config.fontColor)))
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/');
            }
            if (index == 2) {
              Navigator.pushNamed(context, '/bio',
                  arguments: {'jwt': this.jwt});
            }
            if (index == 1) {
              Navigator.pushNamed(context, '/review',
                  arguments: {'jwt': this.jwt});
            }
            if (index == 3) {
              Navigator.pushNamed(context, '/task',
                  arguments: {'jwt': this.jwt});
            }
            setState(() {
              this.currindex = index;
            });
          },
        ));
  }
}
