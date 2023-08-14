import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:limoverse_widgets/utils.dart';

class CubicBezierCurve extends StatefulWidget {
  const CubicBezierCurve({super.key});

  @override
  State<CubicBezierCurve> createState() => _CubicBezierCurveState();
}

class _CubicBezierCurveState extends State<CubicBezierCurve> {
  final ValueNotifier<Offset> localPosition = ValueNotifier(const Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                print(details.localPosition);
                localPosition.value = details.localPosition;
              },
              child: Stack(
                children: [
                  Container(
                    color: Colors.cyanAccent.withOpacity(.10),
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
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              color: Colors.transparent,
              height: 250,
              width: double.maxFinite,
              child: CustomPaint(
                painter: CubicBezierCurvePainter(),
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
                onPressed: () {
                  String credentials = "419052:hGJFLyZ0iWF9MWocn37w";
                  Codec<String, String> stringToBase64 = utf8.fuse(base64);
                  String encoded = stringToBase64.encode(credentials);
                  String decoded = stringToBase64.decode(encoded);
                  print(encoded);
                  print(decoded);
                },
                child: const Text("Generate Base 64")),
            const SizedBox(height: 50),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5)
                      .copyWith(left: 20, right: 10),
                  margin: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          HexColor("#1C3258"),
                          HexColor("#1C3258").withOpacity(.50),
                        ],
                        stops: const [0.5, 1],
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      )),
                  child: const Text("Epigenetics",
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontStyle: FontStyle.italic)),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.cyanAccent),
                      gradient: LinearGradient(colors: [
                        HexColor("#1C3258"),
                        HexColor("#1C3258"),
                      ])),
                  child: const Center(
                      child: Icon(Icons.access_time_sharp,
                          color: Colors.cyanAccent)),
                ),
              ],
            )
          ],
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
      ..strokeWidth = 1.0;

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

    canvas.drawCircle(p0, 4, dotPaint);
    canvas.drawCircle(p1, 4, dotPaint);
    canvas.drawCircle(p2, 4, dotPaint);
    canvas.drawCircle(p3, 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CubicBezierCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final List<double> dataPoints = [
      0,
      20,
      0,
      size.height,
      40,
      30,
      0,
      20,
      0,
      size.height,
      40,
      30
    ];
    final path = Path();

    final double dataPointSpacing = size.width / (dataPoints.length - 1);
    final double graphHeight = size.height;

    path.moveTo(0, graphHeight - dataPoints[0]);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < dataPoints.length - 1; i++) {
      final double x1 = i * dataPointSpacing;
      final double y1 = graphHeight - dataPoints[i];

      final double x2 = (i + 1) * dataPointSpacing;
      final double y2 = graphHeight - dataPoints[i + 1];

      final double controlPointX1 = x1 + dataPointSpacing / 2;
      final double controlPointY1 = y1;

      final double controlPointX2 = x2 - dataPointSpacing / 2;
      final double controlPointY2 = y2;

      path.cubicTo(
        controlPointX1,
        controlPointY1,
        controlPointX2,
        controlPointY2,
        x2,
        y2,
      );
    }

    const gradient = LinearGradient(
      colors: [Colors.blue, Colors.green],
    );

    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
