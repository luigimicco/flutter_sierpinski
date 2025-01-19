import 'package:flutter/material.dart';

import 'triangle_painter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fractal Sierpiński',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _level = 0;
  late int maxLevel = 10;
  late int minLevel = 0;

  late Animation<double> progress;
  late AnimationController controller;
  late int level = 0;

  Tween<double> tLevel = Tween<double>(begin: 0, end: 0);

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    final Animation curveAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);

    progress = tLevel.animate(curveAnimation as Animation<double>)
      ..addListener(() => _onProgressChanged(progress.value))
      ..addStatusListener((status) async {
        if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  void _onProgressChanged(double value) {
    setState(() {
      _level = value.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Livello: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Slider(
                      min: minLevel.toDouble(),
                      max: maxLevel.toDouble(),
                      divisions: (maxLevel - minLevel),
                      label: '${level.round()}',
                      value: level.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          level = value.toInt();
                          tLevel.end = value;
                          controller.reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomPaint(
                    painter: TrianglePainter(_level),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
