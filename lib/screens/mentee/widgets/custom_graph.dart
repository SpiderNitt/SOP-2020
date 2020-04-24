import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularPercentage extends StatelessWidget {
  final double _radius;
  final double _lineWidth;
  final double _percent;
  final _center;
  final _color;

  CircularPercentage(
      this._radius, this._lineWidth, this._percent, this._center, this._color);
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: _radius,
      lineWidth: _lineWidth,
      percent: _percent,
      center: _center,
      progressColor: _color,
    );
  }
}
