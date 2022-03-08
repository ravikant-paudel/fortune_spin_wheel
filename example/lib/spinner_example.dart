import 'package:flutter/material.dart';
import 'package:fortune_spin_wheel/flutter_fortune_spin_wheel.dart';

class SpinnerExample extends StatelessWidget {
  SpinnerExample({Key? key}) : super(key: key);

  final items = [
    FortuneItem(child: Text('Apple'), style: FortuneItemStyle(color: Colors.red)),
    FortuneItem(child: Text('Ball'), style: FortuneItemStyle(color: Colors.purple)),
    FortuneItem(child: Text('Cat'), style: FortuneItemStyle(color: Colors.green)),
    FortuneItem(child: Text('Doll'), style: FortuneItemStyle(color: Colors.blue)),
    FortuneItem(child: Text('Elephant'), style: FortuneItemStyle(color: Colors.deepOrange)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FortuneWheel(items: items));
  }
}
