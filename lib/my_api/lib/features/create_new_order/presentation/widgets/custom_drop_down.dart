// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math' as math;

import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = 30.0;
const double _kDenseButtonHeight = 24.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.only(left: 12, right: 20);
const EdgeInsetsGeometry _kAlignedButtonPadding = EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;
const EdgeInsets _kAlignedMenuMargin = EdgeInsets.zero;
const EdgeInsetsGeometry _kUnalignedMenuMargin = EdgeInsetsDirectional.only(start: 16.0, end: 24.0);
double menuHeight = 0;

class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter({
    required this.color,
    required this.elevation,
    required this.selectedIndex,
    required this.resize,
    required this.shadowColor,
    required this.route,
  })  : _painter = BoxDecoration(
          // If you add an image here, you must provide a real
          // configuration in the paint() function and you must provide some sort
          // of onChanged callback here.
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(0.0, 1.0),
              blurRadius: 1.0,
              spreadRadius: 1.0,
              color: shadowColor ?? const Color(0x1F000000),
            ),
          ],
        ).createBoxPainter(),
        super(repaint: resize);

  final Color color;
  final int elevation;
  final int selectedIndex;
  final Animation<double> resize;
  final Color? shadowColor;
  final _DropdownRoute route;

  final BoxPainter _painter;

  @override
  void paint(Canvas canvas, Size size) {
    final double selectedItemOffset = selectedIndex * _kMenuItemHeight + kMaterialListPadding.top;
    final Tween<double> top = Tween<double>(
      begin: selectedItemOffset.clamp(0.0, size.height - _kMenuItemHeight),
      end: 0.0,
    );

    double canvarHeight = getMenuHeight();

    // final Tween<double> bottom = Tween<double>(
    //   begin: (top.begin! + _kMenuItemHeight).clamp(_kMenuItemHeight, size.height),
    //   end: size.height,
    // );

    final Rect rect = Rect.fromLTRB(0.0, top.evaluate(resize), size.width, canvarHeight);

    _painter.paint(canvas, rect.topLeft, ImageConfiguration(size: rect.size));
  }

  double getMenuHeight() {
    menuHeight = route.items.length * 30;
    if (menuHeight > 220) {
      return 220;
    }
    return menuHeight + 50;
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.elevation != elevation ||
        oldPainter.selectedIndex != selectedIndex ||
        oldPainter.resize != resize;
  }
}

// Do not use the platform-specific default scroll configuration.
// Dropdown menus should never overscroll or display an overscroll indicator.
class _DropdownScrollBehavior extends ScrollBehavior {
  const _DropdownScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) => Theme.of(context).platform;

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails axisDirection) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const ClampingScrollPhysics();
}

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({
    Key? key,
    required this.padding,
    required this.route,
  }) : super(key: key);

  final _DropdownRoute<T> route;
  final EdgeInsets padding;

  @override
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  late CurvedAnimation _fadeOpacity;
  late CurvedAnimation _resize;

  List<DropdownMenuItem<T>> items = [];
  List<DropdownMenuItem<T>> origionalItems = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    items.addAll(widget.route.items);
    origionalItems.addAll(widget.route.items);

    super.initState();
    // We need to hold these animations as state because of their curve
    // direction. When the route's animation reverses, if we were to recreate
    // the CurvedAnimation objects in build, we'd lose
    // CurvedAnimation._curveDirection.
    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.25, 0.5),
      reverseCurve: const Threshold(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The menu is shown in three stages (unit timing in brackets):
    // [0s - 0.25s] - Fade in a rect-sized menu container with the selected item.
    // [0.25s - 0.5s] - Grow the otherwise empty menu container from the center
    //   until it's big enough for as many items as we're going to show.
    // [0.5s - 1.0s] Fade in the remaining visible items from top to bottom.
    //
    // When the menu is dismissed we just fade the entire thing out
    // in the first 0.25s.
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route;
    final double unit = 0.5 / (items.length + 1.5);
    final List<Widget> children = <Widget>[];
    for (int itemIndex = 0; itemIndex < items.length; ++itemIndex) {
      CurvedAnimation opacity;
      if (itemIndex == route.selectedIndex) {
        opacity = CurvedAnimation(parent: route.animation!, curve: const Threshold(0.0));
      } else {
        final double start = (0.5 + (itemIndex + 1) * unit).clamp(0.0, 1.0);
        final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
        opacity = CurvedAnimation(parent: route.animation!, curve: Interval(start, end));
      }
      children.add(
        FadeTransition(
          opacity: opacity,
          child: InkWell(
            child: Container(padding: widget.padding, child: items[itemIndex]),
            onTap: () => Navigator.pop(context, _DropdownRouteResult<T?>(items[itemIndex].value)),
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: _fadeOpacity,
      child: SizedBox(
        height: widget.route.maxDialogHeight,
        width: widget.route.maxDialogWidth,
        child: CustomPaint(
          painter: _DropdownMenuPainter(
            color: Theme.of(context).canvasColor,
            elevation: route.elevation,
            selectedIndex: route.selectedIndex,
            resize: _resize,
            shadowColor: route.shadowColor,
            route: widget.route,
          ),
          child: Semantics(
            scopesRoute: true,
            namesRoute: true,
            explicitChildNodes: true,
            label: localizations.popupMenuLabel,
            child: Material(
              type: MaterialType.transparency,
              textStyle: route.style,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.r, right: 8.r, top: 8.r),
                    child: SizedBox(
                      height: 30.h,
                      child: TextField(
                        controller: searchController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 8, right: 10, left: 10),
                          counterText: "",
                          // contentPadding: EdgeInsets.only(bottom: 8.h, right: 8.w, left: 8.w),
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: Theme.of(context).textTheme.body2BookHeading.copyWith(
                                color: appConstants.neutral5Color,
                              ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide(color: appConstants.themeColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide(color: appConstants.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide(color: appConstants.themeColor),
                          ),
                        ),
                        onChanged: (value) {
                          items.clear();

                          if (value.toString().trim().isEmpty) {
                            items.addAll(origionalItems);
                          } else {
                            items.addAll(
                              origionalItems
                                  .where(
                                    (element) => element.value.toString().toLowerCase().contains(value.toLowerCase()),
                                  )
                                  .toList(),
                            );
                          }

                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: const _DropdownScrollBehavior(),
                      child: RawScrollbar(
                        thumbColor: appConstants.theme1Color,
                        trackColor: appConstants.theme4Color,
                        controller: widget.route.scrollController,
                        trackRadius: Radius.circular(16.r),
                        thumbVisibility: true,
                        trackVisibility: true,
                        interactive: true,
                        radius: Radius.circular(16.r),
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                        child: ListView(
                          controller: widget.route.scrollController,
                          padding: kMaterialListPadding,
                          itemExtent: _kMenuItemHeight,
                          shrinkWrap: true,
                          children: children,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    required this.buttonRect,
    required this.menuTop,
    required this.menuHeight,
    required this.textDirection,
    required this.maxDialogHeight,
    required this.maxDialogWidth,
  });

  final Rect buttonRect;
  final double menuTop;
  final double menuHeight;
  final TextDirection textDirection;
  final double maxDialogHeight;
  final double maxDialogWidth;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The maximum height of a simple menu should be one or more rows less than
    // the view height. This ensures a tappable area outside of the simple menu
    // with which to dismiss the menu.
    //   -- https://material.google.com/components/menus.html#menus-simple-menus
    // final double maxHeight = math.max(0.0, constraints.maxHeight - 2 * _kMenuItemHeight);
    // The width of a menu should be at most the view width. This ensures that
    // the menu does not extend past the left and right edges of the screen.
    // final double width = math.min(constraints.maxWidth, buttonRect.width);
    return BoxConstraints(
      minWidth: maxDialogWidth < 100.w ? maxDialogWidth : 100.w,
      maxWidth: maxDialogWidth,
      minHeight: 100,
      maxHeight: 300,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        // If the button was entirely on-screen, then verify
        // that the menu is also on-screen.
        // If the button was a bit off-screen, then, oh well.
        assert(menuTop >= 0.0);
        assert(menuTop + menuHeight <= size.height);
      }
      return true;
    }());
    double left;
    switch (textDirection) {
      case TextDirection.rtl:
        left = buttonRect.right.clamp(0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = buttonRect.left.clamp(3, size.width - childSize.width);
        break;
    }
    return Offset(left, menuTop);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        menuTop != oldDelegate.menuTop ||
        menuHeight != oldDelegate.menuHeight ||
        textDirection != oldDelegate.textDirection;
  }
}

class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T? result;

  @override
  bool operator ==(dynamic other) {
    if (other is! _DropdownRouteResult<T?>) return false;
    final _DropdownRouteResult<T?> typedOther = other;
    return result == typedOther.result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T?>> {
  _DropdownRoute({
    required this.items,
    this.padding = EdgeInsets.zero,
    this.buttonRect = Rect.zero,
    this.selectedIndex = 0,
    this.elevation = 8,
    this.theme,
    required this.style,
    this.barrierLabel = '',
    required this.scrollController,
    this.shadowColor,
    this.maxDialogHeight = 300,
    this.maxDialogWidth = 180,
  });

  final List<DropdownMenuItem<T>> items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final ThemeData? theme;
  final TextStyle? style;
  final Color? shadowColor;

  ScrollController scrollController;
  double maxDialogWidth;
  double maxDialogHeight;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    assert(debugCheckHasDirectionality(context));
    final double screenHeight = MediaQuery.of(context).size.height;
    final double maxMenuHeight = screenHeight - 2.0 * _kMenuItemHeight;
    final double preferredMenuHeight = (items.length * _kMenuItemHeight) + kMaterialListPadding.vertical;
    final double menuHeight = math.min(maxMenuHeight, preferredMenuHeight);

    final double buttonTop = buttonRect.top;
    final double selectedItemOffset = selectedIndex * _kMenuItemHeight + kMaterialListPadding.top;
    double menuTop = (buttonTop - selectedItemOffset) - (_kMenuItemHeight - buttonRect.height) / 1.3;
    const double topPreferredLimit = _kMenuItemHeight;
    if (menuTop < topPreferredLimit) menuTop = math.min(buttonTop, topPreferredLimit);
    double bottom = menuTop + menuHeight;
    final double bottomPreferredLimit = screenHeight - _kMenuItemHeight;
    if (bottom > bottomPreferredLimit) {
      bottom = math.max(buttonTop + _kMenuItemHeight, bottomPreferredLimit);
      menuTop = bottom - menuHeight;
    }

    final TextDirection textDirection = Directionality.of(context);
    Widget menu = _DropdownMenu<T>(
      route: this,
      padding: padding.resolve(textDirection),
    );

    menu = Theme(data: theme ?? Theme.of(context), child: menu);

    return Padding(
      padding: EdgeInsets.only(top: 16.h, left: 16.w),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        child: Builder(
          builder: (BuildContext context) {
            return CustomSingleChildLayout(
              delegate: _DropdownMenuRouteLayout<T>(
                buttonRect: buttonRect,
                menuTop: menuTop,
                menuHeight: menuHeight,
                textDirection: textDirection,
                maxDialogHeight: maxDialogHeight,
                maxDialogWidth: maxDialogWidth,
              ),
              child: menu,
            );
          },
        ),
      ),
    );
  }

  void _dismiss() {
    navigator?.removeRoute(this);
  }
}

class CustomDropdownButton<T> extends StatefulWidget {
  /// Creates a dropdown button.
  ///
  /// The [items] must have distinct values and if [value] isn't null it must be among them.
  ///
  /// The [elevation] and [iconSize] arguments must not be null (they both have
  /// defaults, so do not need to be specified).
  CustomDropdownButton({
    Key? key,
    required this.items,
    this.value,
    this.hint,
    required this.onChanged,
    this.elevation = 8,
    this.style,
    this.iconSize = 24.0,
    this.isDense = false,
    required this.scrollController,
    required this.shadowColor,
    this.showHintOnly = false,
    this.maxDialogHeight = 300,
    this.maxDialogWidth = 100,
    this.customDropDownButton,
    this.onTap,
    this.onMenuCLose,
    this.onMenuOpen, required Null Function(dynamic v) onOptionSelected,
  })  : assert(value == null || items.where((DropdownMenuItem<T> item) => item.value == value).length == 1),
        super(key: key);

  final double maxDialogHeight;
  final double maxDialogWidth;
  final VoidCallback? onTap;
  final VoidCallback? onMenuCLose;
  final VoidCallback? onMenuOpen;
  final Widget? customDropDownButton;

  /// The list of possible items to select among.
  final List<DropdownMenuItem<T>> items;

  final bool showHintOnly;

  /// The currently selected item, or null if no item has been selected. If
  /// value is null then the menu is popped up as if the first item was
  /// selected.
  final T? value;

  /// Displayed if [value] is null.
  final Widget? hint;

  /// Called when the user selects an item.
  final ValueChanged<T?> onChanged;

  /// The z-coordinate at which to place the menu when open.
  ///
  /// The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12, 16, 24
  ///
  /// Defaults to 8, the appropriate elevation for dropdown buttons.
  final int? elevation;

  /// The text style to use for text in the dropdown button and the dropdown
  /// menu that appears when you tap the button.
  ///
  /// Defaults to the [TextTheme.subhead] value of the current
  /// [ThemeData.textTheme] of the current [Theme].
  final TextStyle? style;

  /// The size to use for the drop-down button's down arrow icon button.
  ///
  /// Defaults to 24.0.
  final double? iconSize;

  /// Reduce the button's height.
  ///
  /// By default this button's height is the same as its menu items' heights.
  /// If isDense is true, the button's height is reduced by about half. This
  /// can be useful when the button is embedded in a container that adds
  /// its own decorations, like [InputDecorator].
  final bool isDense;
  final Color? shadowColor;

  final ScrollController scrollController;

  @override
  _DropdownButtonState<T> createState() => _DropdownButtonState<T>();
}

class _DropdownButtonState<T> extends State<CustomDropdownButton<T>> with WidgetsBindingObserver {
  int? _selectedIndex;
  _DropdownRoute<T>? _dropdownRoute;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeDropdownRoute();
    super.dispose();
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
  }

  @override
  void didUpdateWidget(CustomDropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    assert(widget.value == null ||
        widget.items.where((DropdownMenuItem<T> item) => item.value == widget.value).length == 1);
    _selectedIndex = null;
    for (int itemIndex = 0; itemIndex < widget.items.length; itemIndex++) {
      if (widget.items[itemIndex].value == widget.value) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  TextStyle get _textStyle => widget.style ?? Theme.of(context).textTheme.titleMedium!;

  void _handleTap() {
    // _updateSelectedIndex();
    final RenderBox itemBox = context.findRenderObject() as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(Offset.zero) & itemBox.size;
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsetsGeometry menuMargin =
        ButtonTheme.of(context).alignedDropdown ? _kAlignedMenuMargin : _kUnalignedMenuMargin;
    assert(_dropdownRoute == null);
    isMenuOpen = true;
    widget.onMenuOpen == null ? const SizedBox.shrink() : widget.onMenuOpen!.call();
    widget.onTap == null ? const SizedBox.shrink() : widget.onTap!.call();
    _dropdownRoute = _DropdownRoute<T>(
      items: widget.items,
      buttonRect: menuMargin.resolve(textDirection).inflateRect(itemRect),
      padding: _kMenuItemPadding.resolve(textDirection),
      selectedIndex: -1,
      elevation: widget.elevation ?? 0,
      shadowColor: widget.shadowColor,
      theme: Theme.of(context),
      style: _textStyle,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      scrollController: widget.scrollController,
      maxDialogHeight: widget.maxDialogHeight,
      maxDialogWidth: widget.maxDialogWidth,
    );

    Timer(const Duration(milliseconds: 0), () {
      Navigator.push(context, _dropdownRoute!).then<void>((_DropdownRouteResult<T?>? newValue) {
        isMenuOpen = false;
        widget.onMenuCLose == null ? const SizedBox.shrink() : widget.onMenuCLose!.call();
        _dropdownRoute = null;
        if (!mounted) return;
        widget.onChanged(newValue?.result);
        setState(() {});
      });
    });

    for (int itemIndex = 0; itemIndex < widget.items.length; itemIndex++) {
      if (widget.items[itemIndex].value == widget.value) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  double get _denseButtonHeight {
    return math.max(_textStyle.fontSize ?? 0, math.max(widget.iconSize ?? 0, _kDenseButtonHeight));
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    // The width of the button and the menu are defined by the widest
    // item and the width of the hint.
    final List<Widget> items = List<Widget>.from(widget.items);
    int hintIndex;
    hintIndex = items.length;
    items.add(
      DefaultTextStyle(
        style: _textStyle.copyWith(color: Theme.of(context).hintColor),
        child: ExcludeSemantics(
          excluding: false,
          child: widget.hint,
        ),
      ),
    );

    final EdgeInsetsGeometry padding =
        ButtonTheme.of(context).alignedDropdown ? _kAlignedButtonPadding : _kUnalignedButtonPadding;

    Widget result = DefaultTextStyle(
      style: _textStyle,
      child: widget.customDropDownButton ??
          Container(
            padding: padding.resolve(Directionality.of(context)),
            height: widget.isDense ? _denseButtonHeight : null,
            decoration: BoxDecoration(
              border: Border.all(color: appConstants.orderScreenSearchFieldBorderColor),
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // If value is null (then _selectedIndex is null) then we display
                // the hint or nothing at all.
                SizedBox(width: 8.w),
                Expanded(
                  child: IndexedStack(
                    index: widget.showHintOnly ? hintIndex : (_selectedIndex ?? hintIndex),
                    alignment: AlignmentDirectional.centerStart,
                    children: items,
                  ),
                ),
                isMenuOpen
                    ? Icon(
                        Icons.arrow_drop_up,
                        size: widget.iconSize,
                        color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70,
                      )
                    : Icon(
                        Icons.arrow_drop_down,
                        size: widget.iconSize,
                        color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70,
                      ),
              ],
            ),
          ),
    );

    return Semantics(
      button: true,
      child: GestureDetector(onTap: _handleTap, behavior: HitTestBehavior.opaque, child: result),
    );
  }
}
