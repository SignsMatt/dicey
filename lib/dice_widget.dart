import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

enum DiceSides { one, two, three, four, five, six }

final dieDot = Container(
  width: 30,
  height: 30,
  decoration: const BoxDecoration(
    color: Colors.black,
    shape: BoxShape.circle, // Forces the container into a circle
  ),
);

List<Widget> dice = [
  Center(child: dieDot),
  Column(
    mainAxisAlignment: .spaceBetween,
    children: [
      Row(mainAxisAlignment: .end, children: [dieDot]),
      Row(mainAxisAlignment: .start, children: [dieDot]),
    ],
  ),
  Column(
    mainAxisAlignment: .spaceBetween,
    children: [
      Row(mainAxisAlignment: .end, children: [dieDot]),
      Row(mainAxisAlignment: .center, children: [dieDot]),
      Row(mainAxisAlignment: .start, children: [dieDot]),
    ],
  ),
  Column(
    mainAxisAlignment: .spaceBetween,
    children: [
      Row(mainAxisAlignment: .spaceBetween, children: [dieDot, dieDot]),
      Row(mainAxisAlignment: .spaceBetween, children: [dieDot, dieDot]),
    ],
  ),
  Column(
    mainAxisAlignment: .spaceBetween,
    children: [
      Row(mainAxisAlignment: .spaceBetween, children: [dieDot, dieDot]),
      Row(mainAxisAlignment: .center, children: [dieDot]),
      Row(mainAxisAlignment: .spaceBetween, children: [dieDot, dieDot]),
    ],
  ),
  Column(
    mainAxisAlignment: .spaceBetween,
    children: [
      Row(mainAxisAlignment: .spaceBetween, children: [dieDot, dieDot]),
      Row(mainAxisAlignment: .spaceBetween, children: [dieDot, dieDot]),
      Row(mainAxisAlignment: .spaceBetween, children: [dieDot, dieDot]),
    ],
  ),
];

class DiceWidget extends StatefulWidget {
  const DiceWidget({super.key});

  @override
  State<DiceWidget> createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  late DiceSides side = rollDie();
  ShakeDetector? _detector;

  DiceSides rollDie() {
    return DiceSides.values[Random().nextInt(6)];
  }

  @override
  void initState() {
    super.initState();

    // Shake detection will throw an exception on desktop platforms.
    // Enable it only on mobile.
    
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      _detector = ShakeDetector.autoStart(
        onPhoneShake: (event) {
          setState(() {
            side = rollDie();
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _detector?.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.contain,
        child: GestureDetector(
          onTap: () {
            setState(() {
              side = rollDie();
            });
          },
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.all(30),
              child: dice[side.index],
            ),
          ),
        ),
      ),
    );
  }
}
