import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel_example/spinner_wheel.dart';
import 'package:fortune_spin_wheel/flutter_fortune_spin_wheel.dart';

class ExamplePage extends StatefulWidget {
  ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
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
  final ScrollController _listScrollController = ScrollController();

  int timerSec = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xff4E267B),
              Color(0xff361957),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 26),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // const KhaltiImage.asset(asset: a_daamiQr),
            // const VerticalGap(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Timer.periodic(Duration(seconds: 1), (timer) {
                  if (timerSec > 200) {
                    timer.cancel();
                  }
                  timerSec += 1;
                  if (mounted) {
                    setState(() {});
                  }
                });
                _spinnerPageKey.currentState?.animationTest([0, -10000, 50000, -60000]);
              },
              child: Text('Test'),
            ),
            ClipPath(
              clipper: CustomClipperImage(),
              child: Container(
                color: Colors.white,
                height: 60,
                width: 30,
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: 80,
              height: 70,
              child: ListView.builder(
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                controller: _listScrollController,
                itemBuilder: (context, i) {
                  return items[i].child;
                },
              ),
            ),
            SizedBox(height: 26),
            Flexible(
              child: FractionallySizedBox(
                alignment: Alignment.topCenter,
                widthFactor: 1.2,
                heightFactor: 1.8,
                child: SpinnerWheelPage(
                  key: _spinnerPageKey,
                  items: items,
                  selectedItem: 2,
                  listScrollController: _listScrollController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipperImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0)
      ..quadraticBezierTo(size.width * 0.6, size.height * 0.2, size.width / 2, size.height)
      // ..lineTo(size.width / 2, size.height)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.2, 0, 0)
      // ..lineTo(size.width / 5, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
