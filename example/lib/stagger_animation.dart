import 'package:flutter/material.dart';

class StaggerDemo extends StatefulWidget {
  @override
  _StaggerDemoState createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo> with TickerProviderStateMixin {
  late final AnimationController controller;

  late final Animation<double> opacity;
  late final Animation<double> width;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<BorderRadius?> borderRadius;
  late final Animation<Color?> color;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.100,
          curve: Curves.ease,
        ),
      ),
    );
    width = Tween<double>(
      begin: 50.0,
      end: 150.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.125,
          0.250,
          curve: Curves.ease,
        ),
      ),
    );
    height = Tween<double>(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.250,
          0.375,
          curve: Curves.ease,
        ),
      ),
    );
    padding = EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 16.0),
      end: const EdgeInsets.only(bottom: 75.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.250,
          0.375,
          curve: Curves.ease,
        ),
      ),
    );
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(4.0),
      end: BorderRadius.circular(75.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.375,
          0.500,
          curve: Curves.ease,
        ),
      ),
    );
    color = ColorTween(
      begin: Colors.indigo[100],
      end: Colors.orange[400],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.500,
          0.750,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (controller.status == AnimationStatus.dismissed) {
            controller.forward();
          } else if (controller.status == AnimationStatus.completed) {
            controller.reverse();
          }
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) => Container(
                padding: padding.value,
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: opacity.value,
                  child: Container(
                    width: width.value,
                    height: height.value,
                    decoration: BoxDecoration(
                      color: color.value,
                      border: Border.all(
                        color: Colors.indigo,
                        width: 3.0,
                      ),
                      borderRadius: borderRadius.value,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //
  // Widget _buildAnimation(BuildContext context, Widget child) {
  //   return Container(
  //     padding: padding.value,
  //     alignment: Alignment.bottomCenter,
  //     child: Opacity(
  //       opacity: opacity.value,
  //       child: Container(
  //         width: width.value,
  //         height: height.value,
  //         decoration: BoxDecoration(
  //           color: color.value,
  //           border: Border.all(
  //             color: Colors.indigo,
  //             width: 3.0,
  //           ),
  //           borderRadius: borderRadius.value,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
