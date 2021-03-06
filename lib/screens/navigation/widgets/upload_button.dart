import 'package:flutter/material.dart';
import '../../../theme/navigation.dart';

class UploadButton extends StatelessWidget {
  final Function function;
  final String text;
  final double _width;
  final double _height;
  final double _fontsize;

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
