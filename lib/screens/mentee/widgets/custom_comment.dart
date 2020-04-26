
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:inductions_20/theme/mentee.dart';
import 'package:url_launcher/url_launcher.dart';


class Comment_box extends StatelessWidget{

final String _text;
final _backgroundColor;
final _textcolor;
final _date;
final _time;
final double _width;
final _username;

Comment_box(this._text, this._backgroundColor, this._textcolor,this._width, this._username, this._date, this._time);

Widget build(BuildContext context) {
  return  Container(
                   constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: _width,
          ),
                  //constraints: BoxConstraints(minWidth: 10, maxWidth: _width),
                  decoration: BoxDecoration(
                    color: _backgroundColor ,
                    borderRadius: BorderRadius.circular(8.0),
                  ),

                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                       Text(_username, 
                      style: TextStyle(fontSize:16,fontWeight: FontWeight.bold, color: _textcolor),),
                      Linkify(
                      onOpen: (link) async {
                       if (await canLaunch(link.url)) {
                       await launch(link.url);
                       } else {
                          throw 'Could not launch $link';
                            }
                           },
                       text: '''$_text''',
                     style: TextStyle(color: _textcolor),
                     linkStyle: TextStyle(color: Colors.white70),
),
                    
                      Padding(
                        padding: EdgeInsets.only(top:5),
                      child:Text('${_date} ${_time}', 
                      style: TextStyle(fontSize:10,fontWeight: FontWeight.bold,color: _textcolor),),
                      )]
                      )


                    ),
              
                );
}

}

class Triangle extends CustomPainter {
  
 
 Color color;
 Triangle(this.color);

  @override

  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    path.lineTo(10, 0);
    path.lineTo(0, -10);
    path.lineTo(-10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

