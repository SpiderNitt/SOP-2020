
import 'package:flutter/material.dart';


class Comment_box extends StatelessWidget{

final String _text;
final _backgroundColor;
final _textcolor;

Comment_box(this._text, this._backgroundColor, this._textcolor);

Widget build(BuildContext context) {
  return  DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(_backgroundColor) ,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('', 
                      style: TextStyle(color: Colors.white),),
                    ),
                  ),
                );
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

