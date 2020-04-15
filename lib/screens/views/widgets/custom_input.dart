import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData _icon;
  final String _hintText;
  final Function _validator;
  final bool _obscureText;
  final TextInputType _type;
  final double _width;
  final double _fontsize;

  CustomInput(this._icon, this._hintText, this._validator, this._obscureText,
      this._type, this._width, this._fontsize);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      child: TextFormField(
        keyboardType: _type,
        obscureText: _obscureText,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: _fontsize,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            _icon,
            color: Color(0xFF00A8E8),
          ),
          hintText: _hintText,
          hintStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: _fontsize,
          ),
          errorStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: _fontsize - 5,
          ),
          fillColor: Color(0xFF00A8E8).withOpacity(0.2),
          filled: true,
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF00A8E8),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF00A8E8),
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF00A8E8),
            ),
          ),
        ),
        validator: _validator,
      ),
    );
  }
}
