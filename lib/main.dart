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

class _MyHomePageState extends State<MyHomePage> {
  int _level = 2;
  late int maxLevel = 10;
  late int minLevel = 0;

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
                      label: '${_level.round()}',
                      value: _level.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          _level = value.toInt();
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
