import 'package:flutter/material.dart';
import '../../../theme/navigation.dart';

class CustomListTile extends StatelessWidget {
  final IconData _icon;
  final dynamic _text;
  final Function _onTap;

  CustomListTile(this._icon, this._text, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.primaryColor,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          _onTap();
        },
        focusColor: theme.primaryColor,
        highlightColor: theme.primaryColor,
        splashColor: theme.tertiaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(_icon, color: theme.tertiaryColor),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                      child: Text(
                        _text,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: theme.fontColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right, color: theme.tertiaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
