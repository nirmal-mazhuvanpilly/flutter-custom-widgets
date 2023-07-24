import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:limoverse_widgets/utils.dart';

class CustomExpandedWidget extends StatefulWidget {
  const CustomExpandedWidget(
      {super.key,
      required this.child,
      this.expandedWidget,
      this.trailColor,
      this.backgroundColor,
      this.dividerColor,
      this.onExpansionChanged,
      this.initiallyExpanded = false,
      this.maintainState = false,
      this.enableDivider = true});

  final Widget child;

  final Widget? expandedWidget;

  final Color? trailColor;

  final Color? backgroundColor;

  final Color? dividerColor;

  final ValueChanged<bool>? onExpansionChanged;

  final bool initiallyExpanded;

  final bool maintainState;
  final bool enableDivider;

  @override
  State<CustomExpandedWidget> createState() => _CustomExpandedWidgetState();
}

class _CustomExpandedWidgetState extends State<CustomExpandedWidget>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    _isExpanded = PageStorage.of(context).readState(context) as bool? ??
        widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget? _buildIcon(BuildContext context) {
    return RotationTransition(
        turns: _iconTurns,
        child: Transform.rotate(
          angle: 180 * math.pi / 360,
          alignment: Alignment.center,
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 11,
          ),
        ));
  }

  Widget? _buildTrailingIcon(BuildContext context) {
    return _buildIcon(context);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: _handleTap,
          child: Column(
            children: [
              Container(
                color: widget.backgroundColor ?? Colors.grey.shade200,
                padding: const EdgeInsets.only(right: 2),
                child: LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: widget.child,
                      ),
                      const SizedBox(width: 8),
                      _buildTrailingIcon(context)!
                    ],
                  );
                }),
              ),
              if (!_isExpanded && widget.enableDivider)
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 13),
                  color: widget.dividerColor ?? HexColor("#F3F3F7"),
                ),
            ],
          ),
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.center,
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: EdgeInsets.zero,
          child: widget.expandedWidget,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
