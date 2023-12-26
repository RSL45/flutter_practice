import 'package:flutter/material.dart';

class WhiteBoardLine {
  List<Offset> points;
  Color color;
  double strokeWidth;

  WhiteBoardLine({
    required this.points,
    this.color = Colors.black,
    this.strokeWidth = 1,
  });
}
