import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:limoverse_widgets/utils.dart';

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> {
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
                child: DistanceAnimation(
                    length: 13,
                    distance: 25,
                    size: 10,
                    distanceEnd: 25 + (25 / 2),
                    color: HexColor("004b23"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 15),
                child: DistanceAnimation(
                    length: 18,
                    distance: 40,
                    size: 10,
                    distanceEnd: 40 + (40 / 2),
                    color: HexColor("006400"))),
            RotatingAnimation(
                duration: const Duration(seconds: 20),
                child: DistanceAnimation(
                    length: 22,
                    distance: 55,
                    size: 10,
                    distanceEnd: 55 + (55 / 2),
                    color: HexColor("007200"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 25),
                child: DistanceAnimation(
                    length: 27,
                    distance: 70,
                    size: 10,
                    distanceEnd: 70 + (70 / 2),
                    color: HexColor("008000"))),
            RotatingAnimation(
                duration: const Duration(seconds: 30),
                child: DistanceAnimation(
                    length: 32,
                    distance: 85,
                    size: 10,
                    distanceEnd: 85 + (85 / 2),
                    color: HexColor("38b000"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 35),
                child: DistanceAnimation(
                    length: 37,
                    distance: 100,
                    size: 10,
                    distanceEnd: 100 + (100 / 2),
                    color: HexColor("70e000"))),
            RotatingAnimation(
                duration: const Duration(seconds: 40),
                child: DistanceAnimation(
                    length: 42,
                    distance: 115,
                    size: 10,
                    distanceEnd: 115 + (115 / 2),
                    color: HexColor("9ef01a"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 45),
                child: DistanceAnimation(
                    length: 47,
                    distance: 130,
                    size: 10,
                    distanceEnd: 130 + (130 / 2),
                    color: HexColor("ccff33"))),
            RotatingAnimation(
                duration: const Duration(seconds: 50),
                child: DistanceAnimation(
                    length: 52,
                    distance: 145,
                    size: 10,
                    distanceEnd: 145 + (145 / 2),
                    color: HexColor("D1FF47"))),
            RotatingAnimation(
                begin: 360,
                end: 0,
                duration: const Duration(seconds: 55),
                child: DistanceAnimation(
                    length: 57,
                    distance: 160,
                    size: 10,
                    distanceEnd: 160 + (160 / 2),
                    color: HexColor("E0FF85"))),
          ],
        ),
      ),
    );
  }
}

class DistanceAnimation extends StatefulWidget {
  final int length;
  final double distance;
  final double size;
  final Color color;
  final double? distanceEnd;
  const DistanceAnimation({
    super.key,
    required this.length,
    required this.distance,
    required this.size,
    required this.color,
    this.distanceEnd,
  });

  @override
  State<DistanceAnimation> createState() => _DistanceAnimationState();
}

class _DistanceAnimationState extends State<DistanceAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    animation = Tween<double>(
            begin: widget.distance, end: widget.distanceEnd ?? widget.distance)
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear));
    animationController.forward();
    statusListener();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  statusListener() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  Offset getOffset(double angle, {double? distance}) {
    final x = (distance ?? 0) * math.cos(angle * (math.pi / 180));
    final y = (distance ?? 0) * math.sin(angle * (math.pi / 180));
    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        child: AnimatedCustomContainer(color: widget.color, size: widget.size),
        builder: (context, child) {
          return Stack(
              children: List.generate(
                  widget.length,
                  (index) => Transform.translate(
                        offset: getOffset(index * (360 / widget.length),
                            distance: animation.value),
                        child: child,
                      )));
        });
  }
}

class AnimatedCustomContainer extends StatefulWidget {
  const AnimatedCustomContainer({
    super.key,
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<AnimatedCustomContainer> createState() =>
      _AnimatedCustomContainerState();
}

class _AnimatedCustomContainerState extends State<AnimatedCustomContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation animation;
  late final Animation sizeAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));

    sizeAnimation = Tween<double>(begin: widget.size, end: widget.size - 2)
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear));
    animationController.forward();
    statusListener();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  statusListener() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
            height: sizeAnimation.value,
            width: sizeAnimation.value,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: widget.color),
          );
        });
  }
}

class RotatingAnimation extends StatefulWidget {
  final Widget child;
  final double? begin;
  final double? end;
  final Duration? duration;

  const RotatingAnimation(
      {super.key, required this.child, this.begin, this.end, this.duration});

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
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.bounceIn));
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
        animation: animationController,
        child: widget.child,
        builder: (context, child) => Transform.rotate(
            angle: animation.value * (math.pi / 180), child: child));
  }
}
