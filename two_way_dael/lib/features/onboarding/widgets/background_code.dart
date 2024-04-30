import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../../core/theming/colors.dart';

class BackgroundCode extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path()
      ..moveTo(size.width * -0.2950308, size.height * 0.9087838)
      ..cubicTo(
          size.width * -0.2950308,
          size.height * 0.9087838,
          size.width * -0.1220684,
          size.height * 0.9124888,
          size.width * -0.09848266,
          size.height * 0.7476914)
      ..cubicTo(
          size.width * -0.07489689,
          size.height * 0.5828940,
          size.width * 0.06271945,
          size.height * 0.6162137,
          size.width * 0.1199144,
          size.height * 0.6162137)
      ..cubicTo(
          size.width * 0.1771094,
          size.height * 0.6162137,
          size.width * 0.2049630,
          size.height * 0.6125087,
          size.width * 0.2049630,
          size.height * 0.6125087)
      ..lineTo(size.width * 0.2049630, size.height * -0.09120849)
      ..lineTo(size.width * -0.2950308, size.height * -0.09120849)
      ..lineTo(size.width * -0.2950308, size.height * 0.9087838)
      ..close();

    path_0.moveTo(size.width * 0.7049692, size.height * 0.9087838);
    path_0.cubicTo(
        size.width * 0.7049692,
        size.height * 0.9087838,
        size.width * 0.5320069,
        size.height * 0.9124888,
        size.width * 0.5084212,
        size.height * 0.7476888);
    path_0.cubicTo(
        size.width * 0.4848354,
        size.height * 0.5828889,
        size.width * 0.3472115,
        size.height * 0.6162214,
        size.width * 0.2900190,
        size.height * 0.6162214);
    path_0.cubicTo(
        size.width * 0.2328265,
        size.height * 0.6162214,
        size.width * 0.2049705,
        size.height * 0.6125164,
        size.width * 0.2049705,
        size.height * 0.6125164);
    path_0.lineTo(size.width * 0.2049705, size.height * -0.09120849);
    path_0.lineTo(size.width * 0.7049718, size.height * -0.09120849);
    path_0.lineTo(size.width * 0.7049718, size.height * 0.9087812);
    path_0.close();

    Paint paint_0_fill = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(
        Offset(size.width * 0.5000000, size.height * 0.5000000),
        size.width * 0.5000000,
        [
          ColorManager.mainOrange.withOpacity(1),
          ColorManager.mainOrange.withOpacity(1)
        ],
        [0, 1],
      );

    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
