import 'dart:math' as _math;

import 'package:flutter/material.dart';
import 'package:fortune_spin_wheel/flutter_fortune_spin_wheel.dart';

class SpinnerWheelPage extends StatefulWidget {
  SpinnerWheelPage({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.listScrollController,
  }) : super(key: key);
  final List<FortuneItem> items;
  final int selectedItem;
  final int fullCircleSec = 10;
  final int spinsSeconds = 80;
  final ScrollController listScrollController;

  @override
  State<SpinnerWheelPage> createState() => SpinnerWheelPageState();
}

class SpinnerWheelPageState extends State<SpinnerWheelPage> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    final listener = widget.listScrollController;
    // double =(4 * _math.pi) / widget.items.length;
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: widget.spinsSeconds));

    print('$totalValue   totalValue');
    _rotationAnimation = Tween<double>(
      begin: -totalValue,
      end: totalValue,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    )..addListener(() {
        // print('${_rotationAnimation.value} ==  VAlue');

        listener.animateTo(
          _rotationAnimation.value * widget.items.length * 5,
          duration: Duration(microseconds: 1),
          curve: Curves.linear,
        );
        // double maxScroll = listener.position.maxScrollExtent;
        // double currentScroll = listener.position.pixels;
        // double delta = 6.0; // or something else..
        // if (maxScroll - currentScroll <= delta) {
        //   // listener.jumpTo(1);
        // }
      });
    // if (_rotationAnimation.value != null) {
    //   print(_rotationAnimation.value);
    //   listener.animateTo(
    //     _rotationAnimation.value,
    //     duration: Duration(microseconds: 1),
    //     curve: Curves.linear,
    //   );
    //   print('_rotationAnimation.value');
    // }
    print('_rotationAnimation.value');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: FortuneWheel(
            items: widget.items,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> animationTest(List<int> stops) async {
    //[0, -1000, 5000, -60000]

    widget.listScrollController.animateTo(
      1,
      curve: Curves.linear,
      duration: Duration(milliseconds: 1),
    );

    var previousStop = 0;
    _animationController.forward(from: 0.5);
    for (final s in stops) {
      final gap = (s.abs() - previousStop).abs();
      if (gap == 0) {
        continue;
      }
      await Future.delayed(Duration(milliseconds: gap));
      print('${totalValue * s / 1000 / widget.spinsSeconds} ======>TOtalValue');
      _animationController.animateTo(totalValue * s / 1000 / widget.spinsSeconds);
      previousStop = s.abs();
    }
    // print('${widget.spinsSeconds - (stops.last.abs() / 1000)} DDDD');
    print('$totalValue totalValue');
    print('${_rotationAnimation.value} _rotation');

    _animationController.animateTo(
      totalValue,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  double get totalValue {
    final rotation = widget.spinsSeconds / widget.fullCircleSec;
    return 2 * rotation * _math.pi + (widget.items.length - widget.selectedItem) * 2 * _math.pi / widget.items.length;
  }
}

class SpinnerItem extends FortuneItem {
  const SpinnerItem({
    required this.child,
    this.style,
  }) : super(child: child, style: style);

  final SpinnerItemStyle? style;
  final Widget child;
}

class SpinnerItemStyle extends FortuneItemStyle {
  const SpinnerItemStyle({
    this.color = Colors.black,
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.textAlign = TextAlign.start,
    this.textStyle = const TextStyle(),
  }) : super(color: color, borderColor: borderColor, borderWidth: borderWidth, textAlign: textAlign, textStyle: textStyle);

  final Color color;
  final Color borderColor;
  final double borderWidth;
  final TextAlign textAlign;
  final TextStyle textStyle;
}
