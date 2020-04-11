import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData _icon;
  final String _hintText;
  final Function _validator;
  final bool _obscureText;
  final TextInputType _type;

  CustomInput(this._icon, this._hintText, this._validator, this._obscureText,
      this._type);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: TextFormField(
        keyboardType: _type,
        obscureText: _obscureText,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 20,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            _icon,
            color: Color(0xFF00A8E8),
          ),
          hintText: _hintText,
          hintStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
          ),
          errorStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
          ),
          fillColor: Color(0xFF00A8E8).withOpacity(0.1),
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
