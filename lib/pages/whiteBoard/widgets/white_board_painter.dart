import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/white_board_line.dart';

class WhiteBoardPainter extends CustomPainter {
  late Paint _paint;
  final List<WhiteBoardLine> lines;

  WhiteBoardPainter({Key? key, required this.lines}) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  void drawLine(Canvas canvas, WhiteBoardLine line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
