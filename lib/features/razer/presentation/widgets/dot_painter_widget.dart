import 'package:flutter/material.dart';

class DotPainterWidget extends CustomPainter {
  final Offset position;

  DotPainterWidget(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()
      ..color = const Color.fromARGB(224, 226, 214, 214)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, boxPaint);

    final dotPaint = Paint()..color = const Color.fromARGB(255, 255, 32, 32);
    canvas.drawCircle(
        Offset(size.width / 2 + position.dx, size.height / 2 + position.dy),
        5,
        dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
