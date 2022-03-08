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
  final List<FortuneItem> items;

  const FortuneWheel({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<FortuneWheel> createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheel> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wheelData = _WheelData(
          constraints: constraints,
          itemCount: widget.items.length,
          textDirection: Directionality.of(context),
        );

        final transformedItems = [
          for (var i = 0; i < widget.items.length; i++)
            TransformedFortuneItem(
              item: widget.items[i],
              angle: _calculateSliceAngle(i, widget.items.length),
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
    );
  }
}
