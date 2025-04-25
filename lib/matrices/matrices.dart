import 'dart:math';
import 'package:flutter/material.dart';
import 'package:limoverse_widgets/extensions.dart';
import 'package:limoverse_widgets/utils.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Matrices extends StatefulWidget {
  const Matrices({super.key});

  @override
  State<Matrices> createState() => _MatricesState();
}

class _MatricesState extends State<Matrices>
    with SingleTickerProviderStateMixin {
  double panStart = 0.0;
  double panY = 0.0;

  final ValueNotifier<double> currentPosition = ValueNotifier(45.0);
  final ValueNotifier<double> sliderValue = ValueNotifier(155.0);

  double getYPosition() {
    if (currentPosition.value < 0) {
      return 0;
    } else if (currentPosition.value > 180) {
      return 180;
    } else {
      return currentPosition.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            panY = (details.localPosition.dy - panStart);
            currentPosition.value = currentPosition.value + (panY / 100);
            if (currentPosition.value < 0) {
              currentPosition.value = 0;
            } else if (currentPosition.value > 180) {
              currentPosition.value = 180;
            }
          },
          onVerticalDragStart: (details) {
            panStart = details.localPosition.dy;
          },
          child: Column(
            children: [
              GradientText(
                " SATURN ",
                style: TextStyle(
                    color: Colors.greenAccent.withOpacity(.50),
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    fontStyle: FontStyle.italic),
                colors: [
                  HexColor("F8DE22"),
                  HexColor("F94C10"),
                  HexColor("C70039"),
                  HexColor("900C3F"),
                ],
              ),
              Expanded(
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  color: Colors.transparent,
                  child: Center(
                    child: ValueListenableBuilder(
                        valueListenable: currentPosition,
                        child: const CylinderWidget(
                          noOfLeafs: 20,
                          child: CustomContainer(),
                        ),
                        builder: (context, value, child) {
                          return ValueListenableBuilder<double>(
                              valueListenable: sliderValue,
                              builder: (context, sliderValue, sliderChild) {
                                return Transform(
                                  transform: Matrix4.identity()
                                    ..rotateX(getYPosition() * pi / 180)
                                    ..rotateZ(sliderValue * pi / 180),
                                  alignment: Alignment.center,
                                  child: child,
                                );
                              });
                        }),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                        .copyWith(bottom: 50),
                child: ValueListenableBuilder<double>(
                    valueListenable: sliderValue,
                    builder: (context, value, child) {
                      return Slider(
                        value: value,
                        max: 180,
                        activeColor: HexColor("C70039"),
                        inactiveColor: HexColor("C70039").withOpacity(.20),
                        onChanged: (double value) {
                          sliderValue.value = value;
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CylinderWidget extends StatefulWidget {
  const CylinderWidget({super.key, this.child, required this.noOfLeafs});

  final Widget? child;

  final int noOfLeafs;

  @override
  State<CylinderWidget> createState() => _CylinderWidgetState();
}

class _CylinderWidgetState extends State<CylinderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> firstAnimation;
  late Animation<double> secondAnimation;
  late Animation<double> thirdAnimation;
  late Animation<double> fourthAnimation;
  final double zAxisRange = 0.0001;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    firstAnimation = Tween<double>(begin: 0, end: 90).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    secondAnimation = Tween<double>(begin: 90, end: 180).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    thirdAnimation = Tween<double>(begin: 180, end: 270).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    fourthAnimation = Tween<double>(begin: 270, end: 360).animate(
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
        animation: animationController,
        child: widget.child,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ...List.generate(widget.noOfLeafs, (index) {
                return (thirdAnimation.value +
                            (index * (90 / widget.noOfLeafs)) <
                        270)
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, zAxisRange)
                          ..rotateY((thirdAnimation.value +
                                  (index * (90 / widget.noOfLeafs))) *
                              (pi / 180)),
                        alignment: FractionalOffset.center,
                        child: child,
                      )
                    : const SizedBox.shrink();
              }).reversed,
              ...List.generate(widget.noOfLeafs, (index) {
                return (thirdAnimation.value +
                            (index * (90 / widget.noOfLeafs)) >
                        270)
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, zAxisRange)
                          ..rotateY((thirdAnimation.value +
                                  (index * (90 / widget.noOfLeafs))) *
                              (pi / 180)),
                        alignment: FractionalOffset.center,
                        child: child,
                      )
                    : const SizedBox.shrink();
              }),
              ...List.generate(widget.noOfLeafs, (index) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, zAxisRange)
                    ..rotateY((fourthAnimation.value +
                            (index * (90 / widget.noOfLeafs))) *
                        (pi / 180)),
                  alignment: FractionalOffset.center,
                  child: child,
                );
              }),
              ...List.generate(widget.noOfLeafs, (index) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, zAxisRange)
                    ..rotateY((secondAnimation.value +
                            (index * (90 / widget.noOfLeafs))) *
                        (pi / 180)),
                  alignment: FractionalOffset.center,
                  child: child,
                );
              }).reversed,
              ...List.generate(widget.noOfLeafs, (index) {
                return (firstAnimation.value +
                            (index * (90 / widget.noOfLeafs)) >
                        90)
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, zAxisRange)
                          ..rotateY((firstAnimation.value +
                                  360 +
                                  (index * (90 / widget.noOfLeafs))) *
                              (pi / 180)),
                        alignment: FractionalOffset.center,
                        child: child,
                      )
                    : const SizedBox.shrink();
              }).reversed,
              ...List.generate(widget.noOfLeafs, (index) {
                return (firstAnimation.value +
                            (index * (90 / widget.noOfLeafs)) <
                        90)
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, zAxisRange)
                          ..rotateY((firstAnimation.value +
                                  (index * (90 / widget.noOfLeafs))) *
                              (pi / 180)),
                        alignment: FractionalOffset.center,
                        child: child,
                      )
                    : const SizedBox.shrink();
              }),
            ],
          );
        });
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: context.sw(size: 0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 5,
                width: 15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    HexColor("F8DE22").withOpacity(1),
                    Colors.transparent,
                  ]),
                  border:
                      Border.all(color: HexColor("F8DE22").withOpacity(.75)),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 5,
                width: 15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    HexColor("F94C10").withOpacity(1),
                    Colors.transparent,
                  ]),
                  border:
                      Border.all(color: HexColor("F94C10").withOpacity(.75)),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 5,
                width: 15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    HexColor("C70039").withOpacity(1),
                    Colors.transparent,
                  ]),
                  border:
                      Border.all(color: HexColor("C70039").withOpacity(.75)),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 5,
                width: 15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    HexColor("900C3F").withOpacity(1),
                    Colors.transparent,
                  ]),
                  border:
                      Border.all(color: HexColor("900C3F").withOpacity(.75)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 150,
          height: 150,
          child: CustomPaint(
            painter: ArcPainter(),
          ),
        ),
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = -pi / 2; // Starting from top
    const sweepAngle = pi; // Half circle
    final paint = Paint()
      ..color = HexColor("EA1179").withOpacity(.20)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
