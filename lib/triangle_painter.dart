import 'package:flutter/material.dart';
import 'dart:math' as math;

class TrianglePainter extends CustomPainter {
  final int level;
  final double zoom;

  TrianglePainter(this.level, this.zoom);

  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    double base = math.min(size.width, size.height) * zoom;
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

    _drawTriangle(canvas, xOff + base / 2, yOff + height, level - 1, base / 2);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return (level != oldDelegate.level);
  }

  void _drawTriangle(
      Canvas canvas, double x1, double y1, int level, double base) {
    if (level >= 0) {
      double height = base * math.sqrt(3 / 4);
      var triangle = Path();
      triangle.moveTo(x1, y1);
      triangle.lineTo(x1 - base / 2, y1 - height);
      triangle.lineTo(x1 + base / 2, y1 - height);
      triangle.close();

      canvas.drawPath(
          triangle,
          _paint
            ..color = _colors[(level % _colors.length)]
            ..style = PaintingStyle.stroke);
      // left
      _drawTriangle(canvas, x1 - base / 2, y1, level - 1, base / 2);
      // right
      _drawTriangle(canvas, x1 + base / 2, y1, level - 1, base / 2);
      // top
      _drawTriangle(canvas, x1, y1 - height, level - 1, base / 2);
    }
  }

  final _colors = [
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.pink,
    Colors.pinkAccent,
  ];
}
