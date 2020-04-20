import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String _text;
  final Function _submit;
  final double _width;
  final double _height;
  final double _fontsize;

  CustomButton(
      this._text, this._submit, this._width, this._height, this._fontsize);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _submit,
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
            _text,
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
