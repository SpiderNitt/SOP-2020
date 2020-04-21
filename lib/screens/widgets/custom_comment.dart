
import 'package:flutter/material.dart';


class Comment_box extends StatelessWidget{

final String _text;
final _backgroundColor;
final _textcolor;
final double _width;
final _username;

Comment_box(this._text, this._backgroundColor, this._textcolor,this._width, this._username);

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
                      Text(_text, 
                      style: TextStyle(color: _textcolor),),
                      Padding(
                        padding: EdgeInsets.only(top:5),
                      child:Text('12/3/2019 5:30pm', 
                      style: TextStyle(fontSize:10,fontWeight: FontWeight.bold,color: _textcolor),),
                      )]
                      )


                    ),
              
                );
}

}

class Triangle extends CustomPainter {
  


  @override

  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Color(0xff00a8e8);

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

