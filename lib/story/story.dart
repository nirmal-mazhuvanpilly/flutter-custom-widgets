import 'dart:math';
import 'package:flutter/material.dart';
import 'package:limoverse_widgets/utils.dart';

class Story extends StatefulWidget {
  final double? startingAngle;
  final int? sections;
  final double? strokeWidth;
  final double? size;

  const Story(
      {super.key,
      this.startingAngle,
      this.sections,
      this.strokeWidth,
      this.size});

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  late final Animation<double> rotatingAnimation;
  late final Animation<double> linearAnimation;
  static const angleInRadians = pi / 180;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animation = Tween<double>(
            begin: 0,
            end: ((360 - (((widget.sections ?? 8) - 1) * 10)) /
                (widget.sections ?? 8)))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear));
    rotatingAnimation = Tween<double>(begin: 0, end: 360).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    linearAnimation = Tween<double>(begin: 0, end: 10).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: widget.size ?? 75,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.grey.shade900,
                      width: widget.strokeWidth ?? 2.5)),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Container(
                    decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  shape: BoxShape.circle,
                )),
              ),
            ),
            if (true)
              Positioned.fill(
                child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: angleInRadians * rotatingAnimation.value,
                        child: CustomPaint(
                          foregroundPainter: MyCustomPainter(
                            animationValue: animation.value,
                            linearAnimationValue: linearAnimation.value,
                            startingAngle: widget.startingAngle,
                            sections: widget.sections,
                            strokeWidth: widget.strokeWidth,
                          ),
                        ),
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final double animationValue;
  final double linearAnimationValue;

  final double? startingAngle;
  final int? sections;
  final double? strokeWidth;

  MyCustomPainter({
    required this.animationValue,
    required this.linearAnimationValue,
    this.startingAngle,
    this.sections,
    this.strokeWidth,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final center = Offset(width / 2, height / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 2.5
      ..shader = LinearGradient(
        colors: [
          HexColor("#FFDC80"),
          HexColor("#FCAF45"),
          HexColor("#F77737"),
          HexColor("#F56040"),
          HexColor("#FD1D1D"),
          HexColor("#E1306C"),
          HexColor("#C13584"),
          HexColor("#833AB4"),
          HexColor("#5B51D8"),
          HexColor("#405DE6"),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromCircle(
        center: center,
        radius: width / 2,
      ));

    final rect = Rect.fromCenter(
        center: center,
        width: width - (strokeWidth ?? 2.5),
        height: height - (strokeWidth ?? 2.5));

    const angleInRadians = pi / 180;

    for (int i = 0; i < (sections ?? 8); i++) {
      canvas.drawArc(
          rect,
          (((startingAngle ?? 270) + (i * 10)) + (animationValue * i)) *
              angleInRadians,
          ((animationValue + linearAnimationValue) * angleInRadians),
          false,
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
