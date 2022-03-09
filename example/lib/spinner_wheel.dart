import 'dart:math' as _math;

import 'package:flutter/material.dart';
import 'package:fortune_spin_wheel/flutter_fortune_spin_wheel.dart';

class SpinnerWheelPage extends StatefulWidget {
  SpinnerWheelPage({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.intervalStops,
  }) : super(key: key);
  final List<FortuneItem> items;
  final List<int> intervalStops;
  final int selectedItem;
  final int fullCircleSec = 5;
  final int nextStep = 20;

  @override
  State<SpinnerWheelPage> createState() => SpinnerWheelPageState();
}

class SpinnerWheelPageState extends State<SpinnerWheelPage> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  // late Animation<double> _rotationAnimation2;
  // late Animation<double> _rotationAnimation3;
  // late Animation<double> _rotationAnimation4;

  @override
  void initState() {
    super.initState();
    // double =(4 * _math.pi) / widget.items.length;
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));

    _rotationAnimation = Tween<double>(
            begin: 0,
            end: 2 * (widget.nextStep / widget.fullCircleSec) * _math.pi +
                (widget.items.length - widget.selectedItem) * 2 * _math.pi / widget.items.length)
        .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastLinearToSlowEaseIn),
    );

    _animationController.forward();

    /* var nextStop = _math.Random().nextInt(widget.items.length);
    final rotation = widget.nextStep / widget.fullCircleSec;

    _rotationAnimation1 = Tween<double>(
      begin: 0,
      end: 2 * 1 * _math.pi + (widget.items.length - widget.selectedItem) * 2 * _math.pi / widget.items.length,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 0.3, curve: Curves.easeIn),
      ),
    );

    _rotationAnimation2 = Tween<double>(
      begin: 0,
      end: 2 * 4 * _math.pi + (widget.items.length - nextStop) * 2 * _math.pi / widget.items.length,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 0.6, curve: Curves.elasticOut),
      ),
    );

    _rotationAnimation2 = Tween<double>(
      begin: 0,
      end: 2 * rotation * _math.pi + (widget.items.length - nextStop) * 2 * _math.pi / widget.items.length,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 0.65, curve: Curves.easeIn),
      ),
    );

    _rotationAnimation3 = Tween<double>(
      begin: 0,
      end: 2 * rotation * _math.pi + (widget.items.length - nextStop) * 2 * _math.pi / widget.items.length,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.65, 0.8),
      ),
    );

    _rotationAnimation4 = Tween<double>(
      end: 0,
      begin: 2 * rotation * _math.pi + (widget.items.length - widget.selectedItem) * 2 * _math.pi / widget.items.length,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.8, 0.95),
      ),
    );

    _animationController.forward();*/

    // final intervals = widget.intervalStops;
    // var currentInterval = 0;

    /*for (var i = 1; i < intervals.length; i++) {
      final duration = intervals[i].abs() - currentInterval.abs();
      _animationController.duration = Duration(seconds: duration);

      final rotation = widget.nextStep / widget.fullCircleSec;
      var nextStop = _math.Random().nextInt(widget.items.length);
      if (i == intervals.length - 1) {
        nextStop = widget.selectedItem;
      }
      print(nextStop.toString());
      print(currentInterval);
      _rotationAnimation = Tween<double>(
        end: 0,
        begin: 2 * rotation * _math.pi + (widget.items.length - nextStop) * 2 * _math.pi / widget.items.length,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.fastLinearToSlowEaseIn),
      );

      print(0.isNegative);
      currentInterval.isNegative ? _animationController.reverse() : _animationController.forward();

      currentInterval = intervals[i];
    }*/

    /*final intervals = widget.intervalStops;
    var currentInterval = 0;
    for (var i = 1; i < intervals.length; i++) {
      final duration = intervals[i].abs() - currentInterval.abs();
      _animationController.duration = Duration(seconds: duration);

      final rotation = widget.nextStep / widget.fullCircleSec;
      var nextStop = _math.Random().nextInt(widget.items.length);
      if (i == intervals.length - 1) {
        nextStop = widget.selectedItem;
      }
      print(nextStop.toString());
      print(currentInterval);
      _rotationAnimation = Tween<double>(
        end: 0,
        begin: 2 * rotation * _math.pi + (widget.items.length - nextStop) * 2 * _math.pi / widget.items.length,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.fastLinearToSlowEaseIn),
      );

      print(0.isNegative);
      currentInterval.isNegative ? _animationController.reverse() : _animationController.forward();

      currentInterval = intervals[i];
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, _) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: FortuneWheel(items: widget.items),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animateSpinner() {
    if (_animationController.status == AnimationStatus.dismissed) {
      _animationController.forward();
    } else if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
    }
  }
}

class SpinnerItem extends FortuneItem {
  SpinnerItem({
    required this.color,
    required this.child,
  }) : super(child: child, style: FortuneItemStyle(color: color));

  final Color color;
  final Widget child;
}

// _rotationAnimation = Tween<double>(
// end: 0,
// begin: 2 * (widget.nextStep / widget.fullCircleSec) * _math.pi +
// (widget.items.length - widget.selectedItem) * 2 * _math.pi / widget.items.length)
// .animate(
// CurvedAnimation(parent: _animationController, curve: Curves.fastLinearToSlowEaseIn),
// );
// _animationController.forward();
