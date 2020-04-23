import 'package:flutter/material.dart';
import '../../../theme/navigation.dart';

class CustomInput extends StatelessWidget {
  final IconData _icon;
  final String _hintText;
  final Function _validator;
  final bool _obscureText;
  final TextInputType _type;
  final double _width;
  final double _fontsize;
  final _controller;
  CustomInput(this._icon, this._hintText, this._validator, this._obscureText,
      this._type, this._width, this._fontsize, this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      child: TextFormField(
        controller: _controller,
        keyboardType: _type,
        obscureText: _obscureText,
        style: TextStyle(
          color: theme.fontColor,
          fontSize: _fontsize,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            _icon,
            color: theme.tertiaryColor,
          ),
          hintText: _hintText,
          hintStyle: TextStyle(
            color: theme.fontColor,
            fontSize: _fontsize,
          ),
          errorStyle: TextStyle(
            color: theme.fontColor,
            fontSize: _fontsize - 5,
          ),
          fillColor: theme.tertiaryColor.withOpacity(0.2),
          filled: true,
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.tertiaryColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.tertiaryColor,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.tertiaryColor,
            ),
          ),
        ),
        validator: _validator,
      ),
    );
  }
}
