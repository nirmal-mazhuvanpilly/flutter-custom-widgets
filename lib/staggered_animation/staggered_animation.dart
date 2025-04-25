import 'package:flutter/material.dart';

class StaggeredListAnimation extends StatefulWidget {
  const StaggeredListAnimation({super.key});

  @override
  State<StaggeredListAnimation> createState() => _StaggeredListAnimationState();
}

class _StaggeredListAnimationState extends State<StaggeredListAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final List<Animation<double>> scaleAnimationList;
  late final List<Animation<double>> fadeAnimationList;
  late final List<Animation<Offset>> slideAnimationList;

  final itemCount = 10;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    scaleAnimationList = List<Animation<double>>.generate(itemCount, (index) {
      final begin = index * (1 / itemCount);
      final end = begin + (1 / itemCount);
      return Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(
          parent: animationController,
          curve: Interval(begin, end, curve: Curves.easeIn)));
    });
    fadeAnimationList = List<Animation<double>>.generate(itemCount, (index) {
      final begin = index * (1 / itemCount);
      final end = begin + (1 / itemCount);
      return Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
          parent: animationController,
          curve: Interval(begin, end, curve: Curves.easeIn)));
    });
    slideAnimationList = List<Animation<Offset>>.generate(itemCount, (index) {
      final begin = index * (1 / itemCount);
      final end = begin + (1 / itemCount);
      return Tween<Offset>(
              begin: const Offset(0.0, 0.0), end: const Offset(0.0, 0.0))
          .animate(CurvedAnimation(
              parent: animationController,
              curve: Interval(begin, end, curve: Curves.easeIn)));
    });
    animationController.repeat();
  }

  void listenAnimationStatus() {
    animationController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          animationController.forward();
          break;
        case AnimationStatus.forward:
          // TODO: Handle this case.
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          // animationController.repeat();
          animationController.reverse();
          break;
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ScaleTransition(
            scale: scaleAnimationList.elementAt(index),
            child: FadeTransition(
              opacity: fadeAnimationList.elementAt(index),
              child: SlideTransition(
                position: slideAnimationList.elementAt(index),
                child: Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          );
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
    return Scaffold(
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ScaleTransition(
            scale: scaleAnimationList.elementAt(index),
            child: FadeTransition(
              opacity: fadeAnimationList.elementAt(index),
              child: SlideTransition(
                position: slideAnimationList.elementAt(index),
                child: Container(
                  height: 100,
                  width: double.maxFinite,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
