// ignore_for_file: deprecated_member_use

import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CallbackSelection = void Function(double duration);

class WaveSlider extends StatefulWidget {
  final double widthWaveSlider;
  final double heightWaveSlider;
  final Color wavActiveColor;
  final Color wavDeactiveColor;
  final Color sliderColor;
  // final Color backgroundColor;
  final Color positionTextColor;
  final double duration;
  final CallbackSelection callbackStart;
  final Color? boxColor;
  final MaterialColor? circleColor;
  final Color? barColor;
  final Color? barBackgroundColor;
  const WaveSlider({
    Key? key,
    required this.duration,
    required this.callbackStart,
    this.widthWaveSlider = 0,
    this.heightWaveSlider = 0,
    this.wavActiveColor = Colors.deepPurple,
    this.wavDeactiveColor = Colors.blueGrey,
    this.sliderColor = Colors.red,
    this.positionTextColor = Colors.white,
    this.boxColor,
    this.circleColor,
    this.barColor,
    this.barBackgroundColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => WaveSliderState();
}

class WaveSliderState extends State<WaveSlider> {
  double widthSlider = 130;
  double heightSlider = 100;
  static const barWidth = 5.0;
  static const selectBarWidth = 20.0;
  double barStartPosition = 0.0;
  double barEndPosition = 50;

  @override
  void initState() {
    var shortSize = MediaQueryData.fromView(WidgetsBinding.instance.window).size.shortestSide;
    widthSlider = (widget.widthWaveSlider < 50) ? (shortSize - 2 - 40) : widget.widthWaveSlider;
    heightSlider = (widget.heightWaveSlider < 50) ? 80.w : widget.heightWaveSlider;
    barEndPosition = widthSlider - 80.w;
    super.initState();
  }

  double getBarStartPosition() {
    return ((barEndPosition) < barStartPosition) ? barEndPosition : barStartPosition;
  }

  double getBarEndPosition() {
    return ((barStartPosition + 80.w) > barEndPosition) ? (barStartPosition + 80.w) : barEndPosition;
  }

  int getStartTime() {
    // ignore: division_optimization
    return (getBarStartPosition() / (widthSlider / widget.duration)).toInt();
  }

  int getEndTime() {
    return ((getBarEndPosition() + 80.w) / (widthSlider / widget.duration)).ceilToDouble().toInt();
  }

  String timeFormatter(int second) {
    Duration duration = Duration(seconds: second);

    List<int> durations = [];
    if (duration.inHours > 0) {
      durations.add(duration.inHours);
    }
    durations.add(duration.inMinutes);
    durations.add(duration.inSeconds);

    return durations.map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            // color: Colors.grey,
            width: 140.w,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                flexbar(),
                bar(
                  position: getBarStartPosition(),
                  colorBG: widget.sliderColor,
                  width: 130.w,
                  callback: (DragUpdateDetails details) {
                    var tmp = barStartPosition + details.delta.dx;
                    if ((barEndPosition - 120.w) > tmp && (tmp >= 0)) {
                      setState(() {
                        barStartPosition += details.delta.dx;
                      });
                    }
                  },
                  callbackEnd: (details) {
                    widget.callbackStart(getStartTime().toDouble());
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget bar({
    double? position,
    Color? colorBG,
    double? width,
    required GestureDragUpdateCallback callback,
    required GestureDragEndCallback? callbackEnd,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: position! >= 0.0 ? position : 0.0),
      child: GestureDetector(
        onHorizontalDragUpdate: callback,
        onHorizontalDragEnd: callbackEnd,
        child: SizedBox(
          width: 16,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 50.w,
                  width: 4,
                  color: widget.barColor,
                ),
              ),
              Container(
                width: 16,
                alignment: Alignment.center,
                child: Icon(Icons.circle, size: 16, color: appConstants.primary1Color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget flexbar() {
    List<double> heightList = [
      40,
      50,
      30,
      10,
      12,
      35,
      10,
      35,
      36,
      34,
      3,
      5,
      18,
      19,
      15,
      14,
      10,
      8,
      48,
      19,
      40,
      50,
      30,
      10,
      12,
      35,
      10,
      35,
      36,
      34,
      3,
      5,
      18,
      19,
      15,
      14,
      10,
      8,
      48,
      19,
      19,
    ];
    return Container(
      height: 50,
      color: widget.barBackgroundColor,
      width: 130.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          heightList.length,
          (index) => Row(
            children: [
              CommonWidget.sizedBox(width: 1.w),
              Container(
                height: heightList[index],
                width: 2.w,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
