import 'package:flutter/material.dart';
import 'config.dart';

class NavigationBar extends StatefulWidget {
  
  @override

  int value;

   NavigationBar(this.value);

  _NavigationBarState createState() => _NavigationBarState(this.value);
}

class _NavigationBarState extends State<NavigationBar> {
  


  int currindex = 0;

  _NavigationBarState(this.currindex);

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
          title: Text('Home', style: TextStyle( fontSize: 15, fontFamily: config.fontFamily, color: config.fontColor))
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.pages),
          title: Text('Reviews', style: TextStyle( fontSize: 15, fontFamily: config.fontFamily, color: config.fontColor))
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Bio', style: TextStyle( fontSize: 15, fontFamily: config.fontFamily, color: config.fontColor))
          )
      ],
      onTap: (index){
        if (index == 0 ){
          Navigator.pushNamed(context, '/');
        }
         if (index == 2 ){
          Navigator.pushNamed(context, '/bio');
        }
        if (index == 1 ){
          Navigator.pushNamed(context, '/review');
        }
          setState((){
            this.currindex = index;
          });
      },
      ) 
    );
  }
}
