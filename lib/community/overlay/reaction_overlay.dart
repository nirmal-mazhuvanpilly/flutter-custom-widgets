import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

class ReactionButton extends StatefulWidget {
  final Widget child;
  const ReactionButton({super.key, required this.child});

  @override
  State<ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<ReactionButton> {
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();
  late AnimationController controller;

  void createOverLayEntry() {
    removeHighlightOverlay();
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;

    assert(overlayEntry == null);

    final fromTop = offset.dy > 350;

    overlayEntry = OverlayEntry(
      opaque: false,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onHorizontalDragStart: (_) {
                controller.reverse();
              },
              onTapUp: (_) {
                controller.reverse();
              },
              onVerticalDragStart: (_) {
                controller.reverse();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              top: topOffset,
              child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: Offset(
                    -1,
                    size.height -
                        (fromTop ? 100 : 0)), // Show overlay based on position
                child: AnimatedReaction(
                  reactionItems: const [
                    'assets/lottie/lottieFour.json',
                    'assets/lottie/lottieTwo.json',
                    'assets/lottie/lottieThree.json',
                    'assets/lottie/lottieOne.json',
                  ],
                  reactionBackGroundWidth: 190,
                  reactionIconSize: 35,
                  fromTop: fromTop,
                  voidCallback: removeHighlightOverlay,
                  reverseReaction: (animationController) {
                    controller = animationController;
                  },
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: GestureDetector(
        onTap: () {
          createOverLayEntry();
        },
        child: widget.child,
      ),
    );
  }
}

class AnimatedReaction extends StatefulWidget {
  final VoidCallback voidCallback;
  final Function(AnimationController) reverseReaction;
  final List<String> reactionItems;
  final double? startingPosition;
  final double? reactionIconSize;
  final double? reactionBackGroundWidth;
  final bool fromTop;
  const AnimatedReaction({
    super.key,
    required this.voidCallback,
    required this.reverseReaction,
    required this.reactionItems,
    this.startingPosition,
    this.reactionIconSize,
    this.reactionBackGroundWidth,
    this.fromTop = true,
  });

  @override
  State<AnimatedReaction> createState() => _AnimatedReactionState();
}

class _AnimatedReactionState extends State<AnimatedReaction>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animation;
  late Animation<double> widthAnimation;
  late Animation<double> positionAnimation;

  final ValueNotifier<bool> opacity = ValueNotifier<bool>(true);

  late final kReactionIconSize = widget.reactionIconSize ?? 30.0;
  late final kReactionBackGroundWidth = widget.reactionBackGroundWidth ?? 180.0;
  late final kStartingPosition = widget.startingPosition ?? 15.0;
  late final kNoOfReactionItems = widget.reactionItems.length;
  late final kSpaceWidth =
      ((kReactionBackGroundWidth - (kStartingPosition * 2)) -
              (kReactionIconSize * kNoOfReactionItems)) /
          (kNoOfReactionItems - 1);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
        reverseDuration: const Duration(milliseconds: 500));

    animation = Tween<double>(begin: widget.fromTop ? 50 : -10, end: 0.0)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.0, .50, curve: Curves.easeInOutExpo),
            reverseCurve:
                const Interval(0.0, .50, curve: Curves.easeInOutExpo)));

    widthAnimation = Tween<double>(
            begin: kReactionIconSize + 15.0, end: kReactionBackGroundWidth)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(.50, 1.0, curve: Curves.easeOutBack),
            reverseCurve:
                const Interval(.50, 1.0, curve: Curves.easeInOutExpo)));

    positionAnimation = Tween<double>(begin: .20, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(.50, 1.0, curve: Curves.easeOutBack),
            reverseCurve:
                const Interval(.50, 1.0, curve: Curves.easeInOutExpo)));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      animationController.forward();
      widget.reverseReaction.call(animationController);
      opacity.value = false;
    });

    animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed) {
          widget.voidCallback();
        } else if (status == AnimationStatus.reverse) {
          opacity.value = true;
        }
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    opacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: opacity,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, animation.value),
            child: Container(
              height: kReactionIconSize + 10,
              width: widthAnimation.value,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: List.generate(
                    kNoOfReactionItems,
                    (index) {
                      return Positioned(
                        left: (((kStartingPosition +
                                        (kReactionIconSize * (index))) +
                                    (kSpaceWidth * (index))) *
                                (widthAnimation.value /
                                    kReactionBackGroundWidth)) *
                            positionAnimation.value,
                        child: GestureDetector(
                          onTap: () {
                            opacity.value = true;
                            animationController.reverse();
                          },
                          child: SizedBox(
                            height: kReactionIconSize,
                            width: kReactionIconSize,
                            child: ReactionIcon(
                                reactionIcon:
                                    widget.reactionItems.elementAt(index)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
      builder: (context, value, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          curve: const Interval(0.0, 0.75, curve: Curves.easeInOutExpo),
          opacity: value ? 0 : 1,
          child: child,
        );
      },
    );
  }
}

class ReactionIcon extends StatelessWidget {
  const ReactionIcon({
    super.key,
    this.reactionIcon,
  });

  final String? reactionIcon;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(reactionIcon ?? "");
  }
}
