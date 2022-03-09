import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel_example/spinner_wheel.dart';
import 'package:fortune_spin_wheel/flutter_fortune_spin_wheel.dart';

class ExamplePage extends StatelessWidget {
  ExamplePage({Key? key}) : super(key: key);

  final List<FortuneItem> items = [
    FortuneItem(child: Icon(Icons.one_k_outlined, size: 60), style: FortuneItemStyle(color: Colors.red)),
    FortuneItem(child: Icon(Icons.two_k_outlined, size: 60), style: FortuneItemStyle(color: Colors.purple)),
    FortuneItem(child: Icon(Icons.three_k_outlined, size: 60), style: FortuneItemStyle(color: Colors.green)),
    FortuneItem(child: Icon(Icons.four_k_outlined, size: 60), style: FortuneItemStyle(color: Colors.blue)),
    FortuneItem(child: Icon(Icons.five_k_outlined, size: 60), style: FortuneItemStyle(color: Colors.orange)),
    FortuneItem(child: Icon(Icons.six_k_outlined, size: 60), style: FortuneItemStyle(color: Colors.brown)),
    FortuneItem(child: Icon(Icons.seven_k_outlined, size: 60), style: FortuneItemStyle(color: Colors.pink)),
  ];

  final GlobalKey<SpinnerWheelPageState> _spinnerPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => _spinnerPageKey.currentState?.animateSpinner(),
            child: Text('Spinner'),
          ),
          Center(
            child: Container(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                  itemCount: items.length,
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: items[index].child,
                    );
                  }),
            ),
          ),
          SizedBox(height: 24),
          Flexible(
            child: SpinnerWheelPage(
              items: items,
              intervalStops: [0, 10, -50, 60],
              selectedItem: 1,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.purple,
    );
  }
}

// super.initState();
//     // double =(4 * _math.pi) / widget.items.length;
//     _animationController = AnimationController(vsync: this, duration: Duration(seconds: widget.nextStep));
//     final intervals = widget.intervalStops;
//     var currentInterval = 0;
//
//     for (var i = 1; i < intervals.length; i++) {
//       final duration = intervals[i].abs() - currentInterval.abs();
//       _animationController.duration = Duration(seconds: duration);
//
//       final rotation = widget.nextStep / widget.fullCircleSec;
//       var nextStop = _math.Random().nextInt(widget.items.length);
//       if (i == intervals.length - 1) {
//         nextStop = widget.selectedItem;
//       }
//       print(nextStop.toString());
//       print(currentInterval);
//       _rotationAnimation =
//           Tween<double>(end: 0, begin: 2 * rotation * _math.pi + (widget.items.length - nextStop) * 2 * _math.pi / widget.items.length)
//               .animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.fastLinearToSlowEaseIn),
//       );
//
//       currentInterval.isNegative ? _animationController.reverse() : _animationController.forward();
//
//       currentInterval = intervals[i];
