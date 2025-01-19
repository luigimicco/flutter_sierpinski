import 'package:flutter/material.dart';
import 'dart:math' as math;

class TrianglePainter extends CustomPainter {
  final int level;

  TrianglePainter(this.level);

  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    double base = math.min(size.width, size.height);
    double height = base * math.sqrt(3 / 4);
    double xOff = (size.width - base) / 2;
    double yOff = (size.height - height) / 2;

    var triangle = Path();
    triangle.moveTo(xOff + base / 2, yOff + 0);
    triangle.lineTo(xOff + 0, yOff + height);
    triangle.lineTo(xOff + base, yOff + height);
    triangle.close();

    canvas.drawPath(
        triangle,
        _paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return (level != oldDelegate.level);
  }
}
