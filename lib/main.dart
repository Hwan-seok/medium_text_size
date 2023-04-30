// ignore_for_file: prefer_const_constructors

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
  final style = TextStyle(
    fontSize: 18,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontFeatures: const [FontFeature.tabularFigures()],
    height: 1.2,
  );
  static const maxLine = 2;
  static const maxWidth = 200.0;

  bool isExpanded = false;
  final text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  String ellipsis = '... Read more';

  Size measureSize(TextPainter textPainter, double maxWidth) {
    textPainter.layout(maxWidth: maxWidth);
    final size = textPainter.size;

    return size;
  }

  int measureTextOffset(
    TextPainter textPainter,
    Size textSize,
    Size ellipsisSize,
  ) {
    final textOffset = Offset(
      textSize.width - ellipsisSize.width,
      textSize.height,
    );
    final pos = textPainter.getPositionForOffset(textOffset);
    final offsetBefore = textPainter.getOffsetBefore(pos.offset) ?? 0;
    return offsetBefore;
  }

  @override
  Widget build(BuildContext context) {
    final span = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter(
      text: span,
      maxLines: maxLine,
      textDirection: TextDirection.ltr,
    );

    final textSize = measureSize(textPainter, maxWidth);

    final ellipsisSpan = TextSpan(
      text: ellipsis,
      style: style.copyWith(
        color: Colors.green,
        decoration: TextDecoration.underline,
      ),
    );

    final ellipsisPainter = TextPainter(
      text: ellipsisSpan,
      textDirection: TextDirection.ltr,
    );

    final ellipsisSize = measureSize(
      ellipsisPainter,
      maxWidth,
    );

    final offsetBeforeEllipsis =
        measureTextOffset(textPainter, textSize, ellipsisSize);

    textPainter.dispose();
    ellipsisPainter.dispose();

    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            decoration: BoxDecoration(border: Border.all()),
            child: Text.rich(
              TextSpan(
                text:
                    isExpanded ? text : text.substring(0, offsetBeforeEllipsis),
                children: [if (!isExpanded) ellipsisSpan],
              ),
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
