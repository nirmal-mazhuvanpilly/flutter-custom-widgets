import 'package:flutter/material.dart';

class CubicBezierCurve extends StatelessWidget {
  const CubicBezierCurve({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          color: Colors.red,
          height: 250,
          width: 250,
          child: CustomPaint(
            painter: BezierCurvePainter(
              p0: const Offset(0, 250),
              p1: const Offset(50, 0),
              p2: const Offset(200, 250),
              p3: const Offset(250, 0),
            ),
          ),
        ),
      ),
    );
  }
}

class BezierCurvePainter extends CustomPainter {
  final Offset p0, p1, p2, p3;

  BezierCurvePainter(
      {required this.p0, required this.p1, required this.p2, required this.p3});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    canvas.drawLine(p0, p1, linePaint);
    canvas.drawLine(p1, p2, linePaint);
    canvas.drawLine(p2, p3, linePaint);



    final path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(path, paint);

    final dotPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    canvas.drawCircle(p0, 5, dotPaint);
    canvas.drawCircle(p1, 5, dotPaint);
    canvas.drawCircle(p2, 5, dotPaint);
    canvas.drawCircle(p3, 5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
