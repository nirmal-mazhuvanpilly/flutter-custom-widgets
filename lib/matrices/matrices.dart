import 'dart:math';
import 'package:flutter/material.dart';
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
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const CylinderWidget(
                              centerWidth: 100,
                              noOfLeafs: 30,
                              child: CustomContainer(),
                            ),
                            CylinderWidget(
                              centerWidth: 0,
                              noOfLeafs: 5,
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent.withOpacity(.10),
                                    gradient: LinearGradient(colors: [
                                      HexColor("F8DE22").withOpacity(.50),
                                      HexColor("F94C10").withOpacity(.50),
                                      HexColor("C70039").withOpacity(.50),
                                      HexColor("900C3F").withOpacity(.50),
                                      Colors.transparent,
                                    ]),
                                    border: Border.all(
                                        color: HexColor("F8DE22")
                                            .withOpacity(.50)),
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ],
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
                        max: 360,
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
  const CylinderWidget(
      {super.key,
      this.child,
      required this.centerWidth,
      required this.noOfLeafs});

  final Widget? child;
  final double centerWidth;
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
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((thirdAnimation.value +
                                  (index * (90 / widget.noOfLeafs))) *
                              (pi / 180))
                          ..translate(widget.centerWidth),
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
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((thirdAnimation.value +
                                  (index * (90 / widget.noOfLeafs))) *
                              (pi / 180))
                          ..translate(widget.centerWidth),
                        alignment: FractionalOffset.center,
                        child: child,
                      )
                    : const SizedBox.shrink();
              }),
              ...List.generate(widget.noOfLeafs, (index) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY((fourthAnimation.value +
                            (index * (90 / widget.noOfLeafs))) *
                        (pi / 180))
                    ..translate(widget.centerWidth),
                  alignment: FractionalOffset.center,
                  child: child,
                );
              }),
              ...List.generate(widget.noOfLeafs, (index) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY((secondAnimation.value +
                            (index * (90 / widget.noOfLeafs))) *
                        (pi / 180))
                    ..translate(widget.centerWidth),
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
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((firstAnimation.value +
                                  360 +
                                  (index * (90 / widget.noOfLeafs))) *
                              (pi / 180))
                          ..translate(widget.centerWidth),
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
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((firstAnimation.value +
                                  (index * (90 / widget.noOfLeafs))) *
                              (pi / 180))
                          ..translate(widget.centerWidth),
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
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5,
            width: 15,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                HexColor("F8DE22").withOpacity(.50),
                Colors.transparent,
              ]),
              border: Border.all(color: HexColor("F8DE22").withOpacity(.50)),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            height: 5,
            width: 15,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                HexColor("F94C10").withOpacity(.50),
                Colors.transparent,
              ]),
              border: Border.all(color: HexColor("F94C10").withOpacity(.50)),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            height: 5,
            width: 15,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                HexColor("C70039").withOpacity(.50),
                Colors.transparent,
              ]),
              border: Border.all(color: HexColor("C70039").withOpacity(.50)),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            height: 5,
            width: 15,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                HexColor("900C3F").withOpacity(.50),
                Colors.transparent,
              ]),
              border: Border.all(color: HexColor("900C3F").withOpacity(.50)),
            ),
          ),
        ],
      ),
    );
    /*return Text(
      "  ----",
      style: TextStyle(
          color: Colors.greenAccent.withOpacity(.50),
          fontWeight: FontWeight.w900,
          fontSize: 50),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(.50),
                Colors.greenAccent,
                Colors.transparent,
                Colors.yellowAccent,
                // Colors.greenAccent,
              ])),
        ),
        Text(
          "DDD",
          style: TextStyle(
              color: Colors.white.withOpacity(.30),
              fontWeight: FontWeight.w900,
              fontSize: 50),
        ),
        Transform(
          transform: Matrix4.skewX(50 * pi / 180),
          alignment: Alignment.center,
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.pinkAccent])),
              height: 50,
              width: 50),
        ),
        Transform(
          transform: Matrix4.skewX(-50 * pi / 180),
          alignment: Alignment.center,
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.purpleAccent])),
              height: 50,
              width: 50),
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Transform(
              transform: Matrix4.skewX(-50 * pi / 180),
              alignment: Alignment.topRight,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.purpleAccent])),
                  height: 50,
                  width: 50),
            ),
            Transform(
              transform: Matrix4.skewX(50 * pi / 180),
              alignment: Alignment.topRight,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.pinkAccent])),
                  height: 50,
                  width: 50),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(.50),
                Colors.greenAccent,
                Colors.transparent,
                Colors.yellowAccent,
                // Colors.greenAccent,
              ])),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform(
              transform: Matrix4.skewX(-50 * pi / 180),
              alignment: Alignment.center,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.white])),
                  height: 75,
                  width: 75),
            ),
            Transform(
              transform: Matrix4.skewX(50 * pi / 180),
              alignment: Alignment.center,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.white])),
                  height: 75,
                  width: 75),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(.50),
                Colors.greenAccent,
                Colors.transparent,
                Colors.yellowAccent,
                // Colors.greenAccent,
              ])),
        ),
      ],
    );*/
  }
}
