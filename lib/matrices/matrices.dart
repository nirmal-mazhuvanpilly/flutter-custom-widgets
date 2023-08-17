import 'dart:math';

import 'package:flutter/material.dart';

class Matrices extends StatefulWidget {
  const Matrices({super.key});

  @override
  State<Matrices> createState() => _MatricesState();
}

class _MatricesState extends State<Matrices>
    with SingleTickerProviderStateMixin {
  double x = 100;

  late AnimationController animationController;
  late Animation<double> firstAnimation;
  late Animation<double> secondAnimation;
  late Animation<double> thirdAnimation;
  late Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()..rotateX(45 * pi / 180),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ...List.generate(45, (index) {
                      return (thirdAnimation.value + (index * 2) < 270)
                          ? Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY((thirdAnimation.value + (index * 2)) *
                                    (pi / 180))
                                ..translate(x),
                              alignment: FractionalOffset.center,
                              child: const CustomContainer(),
                            )
                          : const SizedBox();
                    }).reversed,
                    ...List.generate(45, (index) {
                      return (thirdAnimation.value + (index * 2) > 270)
                          ? Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY((thirdAnimation.value + (index * 2)) *
                                    (pi / 180))
                                ..translate(x),
                              alignment: FractionalOffset.center,
                              child: const CustomContainer(),
                            )
                          : const SizedBox();
                    }),
                    ...List.generate(45, (index) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((fourthAnimation.value + (index * 2)) *
                              (pi / 180))
                          ..translate(x),
                        alignment: FractionalOffset.center,
                        child: const CustomContainer(),
                      );
                    }),
                    ...List.generate(45, (index) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((secondAnimation.value + (index * 2)) *
                              (pi / 180))
                          ..translate(x),
                        alignment: FractionalOffset.center,
                        child: const CustomContainer(),
                      );
                    }).reversed,
                    ...List.generate(45, (index) {
                      return (firstAnimation.value + (index * 2) > 90)
                          ? Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(
                                    (firstAnimation.value + 360 + (index * 2)) *
                                        (pi / 180))
                                ..translate(x),
                              alignment: FractionalOffset.center,
                              child: const CustomContainer(),
                            )
                          : const SizedBox();
                    }).reversed,
                    ...List.generate(45, (index) {
                      return (firstAnimation.value + (index * 2) < 90)
                          ? Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY((firstAnimation.value + (index * 2)) *
                                    (pi / 180))
                                ..translate(x),
                              alignment: FractionalOffset.center,
                              child: const CustomContainer(),
                            )
                          : const SizedBox();
                    }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 250,
      width: 100,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.red,
        Colors.blue,
        Colors.orange,
      ])),
      child: Text(
        "Transform".toUpperCase(),
        style: const TextStyle(
            color: Colors.transparent,
            fontWeight: FontWeight.bold,
            fontSize: 24),
      ),
    );
  }
}
