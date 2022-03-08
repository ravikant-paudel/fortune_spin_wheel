import 'package:flutter/material.dart';
import 'package:fortune_spin_wheel/flutter_fortune_spin_wheel.dart';
import 'dart:math' as _math;

class SpinnerWheelPage extends StatefulWidget {
  SpinnerWheelPage({
    Key? key,
    required this.items,
    required this.selectedItem,
  }) : super(key: key);
  final List<FortuneItem> items;
  final int selectedItem;

  @override
  State<SpinnerWheelPage> createState() => _SpinnerWheelPageState();
}

class _SpinnerWheelPageState extends State<SpinnerWheelPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    // double =(4 * _math.pi) / widget.items.length;
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1));
    _rotationAnimation = Tween<double>(begin: 0, end: ((widget.selectedItem * 2) * _math.pi) / widget.items.length).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.forward();
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
}

// class SpinnerItem {
//   final SpinnerItemStyle? style;
//   final Widget child;
//
//   SpinnerItem({required this.child, this.style});
// }
//
// class SpinnerItemStyle {
//   final FortuneItemStyle style;
//
//
//   SpinnerItemStyle(this.style);
//   // final Color color;
//   // final Color borderColor;
//   // final double borderWidth;
//   // final TextAlign textAlign;
//   // final TextStyle textStyle;
//
//   // SpinnerItemStyle({ this.color = Colors.white,
//   //   this.borderColor = Colors.black,
//   //   this.borderWidth = 1.0,
//   //   this.textAlign = TextAlign.start,
//   //   this.textStyle = const TextStyle(),});
// }
