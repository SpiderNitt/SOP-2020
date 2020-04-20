import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  Function function;
  String text;
  double _width;
  double _height;
  double _fontsize;

  UploadButton(
      this.function, this.text, this._width, this._height, this._fontsize);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      focusColor: Color(0xFF00171f),
      highlightColor: Color(0xFF00171f),
      splashColor: Color(0xFF00A8E8),
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
      child: Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          border: Border.all(
            width: 1.5,
            color: Color(0xFF00A8E8),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: _fontsize,
            ),
          ),
        ),
      ),
    );
  }
}
