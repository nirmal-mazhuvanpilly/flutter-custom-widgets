import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Matrices extends StatefulWidget {
  const Matrices({super.key});

  @override
  State<Matrices> createState() => _MatricesState();
}

class _MatricesState extends State<Matrices>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Transform(
          transform: Matrix4.identity()..rotateX(0 * pi / 180),
          alignment: Alignment.center,
          child: const CylinderWidget(
            child: CustomContainer(),
          ),
        ),
      ),
    );
  }
}

class CylinderWidget extends StatefulWidget {
  const CylinderWidget({super.key, this.child});

  final Widget? child;

  @override
  State<CylinderWidget> createState() => _CylinderWidgetState();
}

class _CylinderWidgetState extends State<CylinderWidget>
    with SingleTickerProviderStateMixin {
  final double centerWidth = 100;
  final int noOfLeafs = 5;

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
              ...List.generate(noOfLeafs, (index) {
                return (thirdAnimation.value + (index * (90 / noOfLeafs)) < 270)
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((thirdAnimation.value +
                                  (index * (90 / noOfLeafs))) *
                              (pi / 180))
                          ..translate(centerWidth),
                        alignment: FractionalOffset.center,
                        child: child,
                      )
                    : const SizedBox.shrink();
              }).reversed,
              ...List.generate(noOfLeafs, (index) {
                return (thirdAnimation.value + (index * (90 / noOfLeafs)) > 270)
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((thirdAnimation.value +
                                  (index * (90 / noOfLeafs))) *
                              (pi / 180))
                          ..translate(centerWidth),
                        alignment: FractionalOffset.center,
                        child: child,
                      )
                    : const SizedBox.shrink();
              }),
              ...List.generate(noOfLeafs, (index) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                        (fourthAnimation.value + (index * (90 / noOfLeafs))) *
                            (pi / 180))
                    ..translate(centerWidth),
                  alignment: FractionalOffset.center,
                  child: child,
                );
              }),
              ...List.generate(noOfLeafs, (index) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                        (secondAnimation.value + (index * (90 / noOfLeafs))) *
                            (pi / 180))
                    ..translate(centerWidth),
                  alignment: FractionalOffset.center,
                  child: child,
                );
              }).reversed,
              ...List.generate(noOfLeafs, (index) {
                return (firstAnimation.value + (index * (90 / noOfLeafs)) > 90)
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((firstAnimation.value +
                                  360 +
                                  (index * (90 / noOfLeafs))) *
                              (pi / 180))
                          ..translate(centerWidth),
                        alignment: FractionalOffset.center,
                        child: child,
                      )
                    : const SizedBox.shrink();
              }).reversed,
              ...List.generate(noOfLeafs, (index) {
                return (firstAnimation.value + (index * (90 / noOfLeafs)) < 90)
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((firstAnimation.value +
                                  (index * (90 / noOfLeafs))) *
                              (pi / 180))
                          ..translate(centerWidth),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 175,
          width: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.white.withOpacity(.50),
            Colors.greenAccent,
            Colors.transparent,
            Colors.yellowAccent,
            // Colors.greenAccent,
          ])),
        ),
        Transform.rotate(
          angle: 90 * pi / 180,
          child: GradientText(
            "XXX",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 100,
                fontWeight: FontWeight.w900),
            colors: const [Colors.orange, Colors.transparent],
            gradientDirection: GradientDirection.btt,
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.white.withOpacity(.50),
            Colors.greenAccent,
            Colors.transparent,
            Colors.yellowAccent,
            // Colors.greenAccent,
          ])),
        ),
        Transform.rotate(
          angle: 90 * pi / 180,
          child: GradientText(
            "XXX",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 100,
                fontWeight: FontWeight.w900),
            colors: const [Colors.orange, Colors.transparent],
            gradientDirection: GradientDirection.btt,
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 175,
          width: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.white.withOpacity(.50),
            Colors.greenAccent,
            Colors.transparent,
            Colors.yellowAccent,
            // Colors.greenAccent,
          ])),
        ),
      ],
    );
  }
}
