import 'package:flutter/material.dart';

class Custom_box extends StatelessWidget{

final String _text;
final  _ontap;
final double _width;
final double _height;
final double _fontsize;
final  _backgroundcolor;
final double _padding;
final double _margin;
final double _borderRadius;

Custom_box(
  this._text, this._ontap, this._width, this._height, this._fontsize, this._backgroundcolor, this._padding, this._margin, this._borderRadius);

Widget build(BuildContext context) {
  return InkWell(
    onTap: _ontap,
    
    child: Container(
      padding: EdgeInsets.all(_padding),
      margin: EdgeInsets.all(_margin),
      
      height:_height,
      width: _width,

      decoration: BoxDecoration(
        color: Color(_backgroundcolor),
        borderRadius: BorderRadius.circular(_borderRadius)
      ),
    child: Text('${_text}',
            textAlign: TextAlign.center,
            style:TextStyle(
            fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize:_fontsize 
            ),
    
    )

    ),

 
 

  );
}



}