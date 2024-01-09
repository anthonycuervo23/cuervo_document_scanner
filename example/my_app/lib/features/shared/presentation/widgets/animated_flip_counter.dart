// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class AnimatedFlipCounter extends StatelessWidget {
  final num value;
  final Duration duration;
  final Curve curve;
  final TextStyle? textStyle;
  final String? prefix;
  final String? suffix;
  final int fractionDigits;
  final int wholeDigits;
  final String? thousandSeparator;
  final String decimalSeparator;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets padding;
  const AnimatedFlipCounter({
    Key? key,
    required this.value,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.textStyle,
    this.prefix,
    this.suffix,
    this.fractionDigits = 0,
    this.wholeDigits = 1,
    this.thousandSeparator,
    this.decimalSeparator = '.',
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding = EdgeInsets.zero,
  })  : assert(fractionDigits >= 0, "fractionDigits must be non-negative"),
        assert(wholeDigits >= 0, "wholeDigits must be non-negative"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style.merge(textStyle);
    final prototypeDigit = TextPainter(
      text: TextSpan(text: "8", style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    final Color color = style.color ?? const Color(0xFFB75400);
    final int value = (this.value * math.pow(10, fractionDigits)).round();
    List<int> digits = value == 0 ? [0] : [];
    int v = value.abs();
    while (v > 0) {
      digits.add(v);
      v = v ~/ 10;
    }
    while (digits.length < wholeDigits + fractionDigits) {
      digits.add(0);
    }
    digits = digits.reversed.toList(growable: false);
    final integerWidgets = <Widget>[];
    for (int i = 0; i < digits.length - fractionDigits; i++) {
      final digit = _SingleDigitFlipCounter(
        key: ValueKey(digits.length - i),
        value: digits[i].toDouble(),
        duration: duration,
        curve: curve,
        size: prototypeDigit.size,
        color: color,
        padding: padding,
      );
      integerWidgets.add(digit);
    }

    if (thousandSeparator != null) {
      int counter = 0;
      for (int i = integerWidgets.length; i > 0; i--) {
        if (counter > 0 && counter % 3 == 0) {
          integerWidgets.insert(i, Text(thousandSeparator!));
        }
        counter++;
      }
    }

    return DefaultTextStyle.merge(
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (prefix != null) Text(prefix!),
          ClipRect(
            child: TweenAnimationBuilder(
              duration: duration,
              tween: Tween(end: value < 0 ? 1.0 : 0.0),
              builder: (_, double v, __) => Center(
                widthFactor: v,
                child: Opacity(opacity: v, child: const Text("-")),
              ),
            ),
          ),
          ...integerWidgets,
          if (fractionDigits != 0) Text(decimalSeparator),
          for (int i = digits.length - fractionDigits; i < digits.length; i++)
            _SingleDigitFlipCounter(
              key: ValueKey("decimal$i"),
              value: digits[i].toDouble(),
              duration: duration,
              curve: curve,
              size: prototypeDigit.size,
              color: color,
              padding: padding,
            ),
          if (suffix != null) Text(suffix!),
        ],
      ),
    );
  }
}

class _SingleDigitFlipCounter extends StatelessWidget {
  final double value;
  final Duration duration;
  final Curve curve;
  final Size size;
  final Color color;
  final EdgeInsets padding;

  const _SingleDigitFlipCounter({
    Key? key,
    required this.value,
    required this.duration,
    required this.curve,
    required this.size,
    required this.color,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(end: value),
      duration: duration,
      curve: curve,
      builder: (_, double value, __) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        final w = size.width + padding.horizontal;
        final h = size.height + padding.vertical;

        return SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: [
              buildSingleDigit(
                digit: whole % 10,
                offset: h * decimal,
                opacity: 1 - decimal,
              ),
              buildSingleDigit(
                digit: (whole + 1) % 10,
                offset: h * decimal - h,
                opacity: decimal,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSingleDigit({
    required int digit,
    required double offset,
    required double opacity,
  }) {
    final child;
    if (color.opacity == 1) {
      child = Text(
        '$digit',
        textAlign: TextAlign.center,
        style: TextStyle(color: color.withOpacity(opacity.clamp(0, 1))),
      );
    } else {
      child = Opacity(
        opacity: opacity.clamp(0, 1),
        child: Text(
          '$digit',
          textAlign: TextAlign.center,
        ),
      );
    }
    return Positioned(
      left: 0,
      right: 0,
      bottom: offset + padding.bottom,
      child: child,
    );
  }
}
