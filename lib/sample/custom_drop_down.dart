import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final Widget? child;
  final void Function(T)? onChange;
  final List<DropdownItem<T>>? items;
  final DropdownStyle? dropdownStyle;
  final DropdownButtonStyle? dropdownButtonStyle;
  final Icon? icon;
  final bool hideIcon;
  final bool leadingIcon;

  const CustomDropdown({
    Key? key,
    this.hideIcon = false,
    @required this.child,
    @required this.items,
    this.dropdownStyle,
    this.dropdownButtonStyle,
    this.icon,
    this.leadingIcon = false,
    this.onChange,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle!;
    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        width: style.width,
        height: style.height,
        child: SizedBox(
          height: 52,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: style.primaryColor,
              padding: style.padding,
              backgroundColor: style.backgroundColor,
              elevation: style.elevation,
              shape: style.shape,
              side: const BorderSide(color: Color(0xFF6D737D), width: 1.5),
            ),
            onPressed: _toggleDropdown,
            child: Row(
              mainAxisAlignment:
                  style.mainAxisAlignment ?? MainAxisAlignment.start,
              textDirection:
                  widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
              children: [
                if (_currentIndex == -1) ...[
                  widget.child!,
                ] else ...[
                  widget.items![_currentIndex],
                ],
                const Spacer(),
                if (!widget.hideIcon)
                  RotationTransition(
                    turns: _rotateAnimation,
                    child: widget.icon ??
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Color(0xFF878787),
                        ),
                  ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        onHorizontalDragStart: (_) => _toggleDropdown(close: true),
        onTapUp: (_) => _toggleDropdown(close: true),
        onVerticalDragStart: (_) => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: topOffset,
                width: widget.dropdownStyle?.width ?? size.width,
                child: CompositedTransformFollower(
                  offset: widget.dropdownStyle?.offset ??
                      Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle?.elevation ?? 0,
                    borderRadius:
                        widget.dropdownStyle?.borderRadius ?? BorderRadius.zero,
                    color:
                        widget.dropdownStyle?.color ?? const Color(0xFF1A1C21),
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle?.constraints ??
                            BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height -
                                  topOffset -
                                  15,
                            ),
                        child: ListView(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          shrinkWrap: true,
                          children: widget.items!.asMap().entries.map((item) {
                            return InkWell(
                              onTap: () {
                                setState(() => _currentIndex = item.key);
                                widget.onChange!(item.value.value);
                                _toggleDropdown();
                              },
                              child: item.value,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    FocusScope.of(context).unfocus();
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

class DropdownItem<T> extends StatelessWidget {
  final T value;
  final Widget child;

  const DropdownItem({Key? key, required this.value, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final OutlinedBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;

  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation,
    this.padding,
    this.shape,
  });
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Offset? offset;
  final double? width;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.color,
    this.padding,
    this.borderRadius,
  });
}
