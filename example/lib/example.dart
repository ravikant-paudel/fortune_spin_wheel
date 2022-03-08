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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
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
            child: SpinnerWheelPage(items: items, selectedItem: 1),
          ),
        ],
      ),
      backgroundColor: Colors.purple,
    );
  }
}
