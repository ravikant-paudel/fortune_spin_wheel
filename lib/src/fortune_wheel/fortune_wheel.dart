// import 'package:flutter/material.dart';
// import 'dart:math' as _math;
part of 'wheel.dart';

Offset _calculateWheelOffset(BoxConstraints constraints, TextDirection textDirection) {
  final smallerSide = getSmallerSide(constraints);
  var offsetX = constraints.maxWidth / 2;
  if (textDirection == TextDirection.rtl) {
    offsetX = offsetX * -1 + smallerSide / 2;
  }
  return Offset(offsetX, constraints.maxHeight / 2);
}

double _calculateSliceAngle(int index, int itemCount) {
  final anglePerChild = 2 * _math.pi / itemCount;
  final childAngle = anglePerChild * index;
  // first slice starts at 90 degrees, if 0 degrees is at the top.
  // The angle offset puts the center of the first slice at the top.
  final angleOffset = -(_math.pi / 2 + anglePerChild / 2);
  return childAngle + angleOffset;
}

// double _calculateAlignmentOffset(Alignment alignment) {
//   if (alignment == Alignment.topRight) {
//     return _math.pi * 0.25;
//   }
//
//   if (alignment == Alignment.centerRight) {
//     return _math.pi * 0.5;
//   }
//
//   if (alignment == Alignment.bottomRight) {
//     return _math.pi * 0.75;
//   }
//
//   if (alignment == Alignment.bottomCenter) {
//     return _math.pi;
//   }
//
//   if (alignment == Alignment.bottomLeft) {
//     return _math.pi * 1.25;
//   }
//
//   if (alignment == Alignment.centerLeft) {
//     return _math.pi * 1.5;
//   }
//
//   if (alignment == Alignment.topLeft) {
//     return _math.pi * 1.75;
//   }
//
//   return 0;
// }

class _WheelData {
  final BoxConstraints constraints;
  final int itemCount;
  final TextDirection textDirection;

  late final double smallerSide = getSmallerSide(constraints);
  late final double largerSide = getLargerSide(constraints);
  late final double sideDifference = largerSide - smallerSide;
  late final Offset offset = _calculateWheelOffset(constraints, textDirection);
  late final Offset dOffset = Offset(
    (constraints.maxHeight - smallerSide) / 2,
    (constraints.maxWidth - smallerSide) / 2,
  );
  late final double diameter = smallerSide;
  late final double radius = diameter / 2;
  late final double itemAngle = 2 * _math.pi / itemCount;

  _WheelData({
    required this.constraints,
    required this.itemCount,
    required this.textDirection,
  });
}

class FortuneWheel extends StatefulWidget {
  @override
  State<FortuneWheel> createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheel> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      FortuneItem(child: Text('Apple'), style: FortuneItemStyle(color: Colors.red)),
      FortuneItem(child: Text('Ball'), style: FortuneItemStyle(color: Colors.purple)),
      FortuneItem(child: Text('Cat'), style: FortuneItemStyle(color: Colors.green)),
      FortuneItem(child: Text('Doll'), style: FortuneItemStyle(color: Colors.blue)),
      FortuneItem(child: Text('Elephant'), style: FortuneItemStyle(color: Colors.deepOrange)),
    ];
    return Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, _) {
              // final size = MediaQuery.of(context).size;

              return Transform.rotate(
                angle: (4 * _math.pi) / items.length,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final wheelData = _WheelData(
                      constraints: constraints,
                      itemCount: items.length,
                      textDirection: Directionality.of(context),
                    );

                    final transformedItems = [
                      for (var i = 0; i < items.length; i++)
                        TransformedFortuneItem(
                          item: items[i],
                          angle: _calculateSliceAngle(i, items.length),
                          offset: wheelData.offset,
                        ),
                    ];

                    return SizedBox.expand(
                      child: _CircleSlices(
                        items: transformedItems,
                        wheelData: wheelData,
                        styleStrategy: UniformStyleStrategy(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // child: FortuneWheel(
          //   alignment: alignment.value,
          //   selected: selected.stream,
          //   onAnimationStart: () => isAnimating.value = true,
          //   onAnimationEnd: () => isAnimating.value = false,
          //   onFling: handleRoll,
          //   indicators: [
          //     FortuneIndicator(
          //       alignment: alignment.value,
          //       child: TriangleIndicator(),
          //     ),
          //   ],
          //   items: [
          //     for (var it in Constants.fortuneValues)
          //       FortuneItem(child: Text(it), onTap: () => print(it))
          //   ],
          // ),
        ),
      ],
    );
  }
}
