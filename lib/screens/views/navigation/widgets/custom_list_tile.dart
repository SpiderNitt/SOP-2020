import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData _icon;
  final String _text;
  final Function _onTap;

  CustomListTile(this._icon, this._text, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF00171f),
      child: InkWell(
        onTap: () {},
        focusColor: Color(0xFF00171f),
        highlightColor: Color(0xFF00171f),
        splashColor: Color(0xFF00A8E8).withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(_icon, color: Color(0xFF00A8E8)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                      child: Text(
                        _text,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right, color: Color(0xFF00A8E8)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
