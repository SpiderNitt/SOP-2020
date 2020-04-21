import 'package:flutter/material.dart';
import 'package:inductions_20/theme/styling.dart';

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
      focusColor: theme.primaryColor,
      highlightColor: theme.primaryColor,
      splashColor: theme.tertiaryColor,
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
            color: theme.tertiaryColor,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: theme.fontColor,
              fontSize: _fontsize,
            ),
          ),
        ),
      ),
    );
  }
}
