// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final rand = Random();
  int idx = 0;
  final texts = [
    'One line text',
    '''
1. Two line text
2. which have a different length''',
    '''
Multi line text 
with 
different
length''',
  ];

  String get text => texts[idx];

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 22,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontFeatures: const [FontFeature.tabularFigures()],
      height: 1.2,
    );
    const maxLine = 4;
    const maxWidth = 100.0;

    final span = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter(
      text: span,
      maxLines: maxLine,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);
    final size = textPainter.size;
    textPainter.dispose();
    print("size: $size");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              decoration: BoxDecoration(border: Border.all()),
              child: Text.rich(
                span,
                style: style,
                maxLines: maxLine,
              ),
            ),
            Text(
              'Text size: $size',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: updateText,
        child: const Icon(Icons.update),
      ),
    );
  }

  updateText() {
    idx++;
    idx = idx % texts.length;
    setState(() {});
  }
}
