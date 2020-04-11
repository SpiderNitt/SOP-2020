import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String _text;
  final Function _submit;

  CustomButton(this._text, this._submit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 0),
      child: InkWell(
        onTap: _submit,
        focusColor: Color(0xFF00171f),
        highlightColor: Color(0xFF00171f),
        splashColor: Color(0xFF00A8E8),
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        child: Container(
          height: 50.0,
          width: 280.0,
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
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
