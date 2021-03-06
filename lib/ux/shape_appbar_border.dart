import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';

class CustomShapeBorder extends CustomPainter {
  final size;

  CustomShapeBorder(this.size);

  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [kAzulClaro, kAzulClaro],
      tileMode: TileMode.clamp,
    );

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()
      ..shader = gradient.createShader(colorBounds);

    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2 - (150 / 2) - 30, size.height + 15,
        size.width / 2 - 75, size.height + 50);
    path.cubicTo(
        size.width / 2 - 40,
        size.height + 150 - 40,
        size.width / 2 + 40,
        size.height + 150 - 40,
        size.width / 2 + 75,
        size.height + 50);
    path.quadraticBezierTo(size.width / 2 + (150 / 2) + 30, size.height + 15,
        size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
