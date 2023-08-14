import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:limoverse_widgets/utils.dart';

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> {
  Offset getOffset(double angle, {double? distance}) {
    final x = (distance ?? 0) * math.cos(angle * (math.pi / 180));
    final y = (distance ?? 0) * math.sin(angle * (math.pi / 180));
    return Offset(x, y);
  }

  List<Widget> getCircleDotWidgetList(
      {required int length,
      required double distance,
      required double size,
      required Color color}) {
    return List.generate(
        length,
        (index) => Transform.translate(
              offset: getOffset(index * (360 / length), distance: distance),
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RotatingAnimation(
                children: getCircleDotWidgetList(
                    length: 13,
                    distance: 25,
                    size: 10,
                    color: HexColor("780116"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 15),
                children: getCircleDotWidgetList(
                    length: 18,
                    distance: 40,
                    size: 10,
                    color: HexColor("370617"))),
            RotatingAnimation(
                duration: const Duration(seconds: 20),
                children: getCircleDotWidgetList(
                    length: 22,
                    distance: 55,
                    size: 10,
                    color: HexColor("6a040f"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 25),
                children: getCircleDotWidgetList(
                    length: 27,
                    distance: 70,
                    size: 10,
                    color: HexColor("9d0208"))),
            RotatingAnimation(
                duration: const Duration(seconds: 30),
                children: getCircleDotWidgetList(
                    length: 32,
                    distance: 85,
                    size: 10,
                    color: HexColor("d00000"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 35),
                children: getCircleDotWidgetList(
                    length: 37,
                    distance: 100,
                    size: 10,
                    color: HexColor("dc2f02"))),
            RotatingAnimation(
                duration: const Duration(seconds: 40),
                children: getCircleDotWidgetList(
                    length: 42,
                    distance: 115,
                    size: 10,
                    color: HexColor("e85d04"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 45),
                children: getCircleDotWidgetList(
                    length: 47,
                    distance: 130,
                    size: 10,
                    color: HexColor("f48c06"))),
            RotatingAnimation(
                duration: const Duration(seconds: 50),
                children: getCircleDotWidgetList(
                    length: 52,
                    distance: 145,
                    size: 10,
                    color: HexColor("faa307"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 55),
                children: getCircleDotWidgetList(
                    length: 57,
                    distance: 160,
                    size: 10,
                    color: HexColor("ffba08"))),
          ],
        ),
      ),
    );
  }
}

class RotatingAnimation extends StatefulWidget {
  final List<Widget> children;
  final double? begin;
  final double? end;
  final Duration? duration;

  const RotatingAnimation(
      {super.key, required this.children, this.begin, this.end, this.duration});

  @override
  State<RotatingAnimation> createState() => _RotatingAnimationState();
}

class _RotatingAnimationState extends State<RotatingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: widget.duration ?? const Duration(seconds: 10));
    animation = Tween<double>(begin: widget.begin ?? 0, end: widget.end ?? 360)
        .animate(
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
    return AnimatedBuilder(
      animation: animation,
      child: Stack(
        children: widget.children,
      ),
      builder: (context, child) => Transform.rotate(
          angle: animation.value * (math.pi / 180), child: child),
    );
  }
}
