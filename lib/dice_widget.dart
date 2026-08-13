import 'package:dicey/die_model.dart';
import 'package:flutter/material.dart';

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

class DiceWidget extends StatelessWidget {
  const DiceWidget({required this.die, required this.onTap, super.key});

  final DieModel die;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(30),
            child: dice[die.side.index],
          ),
        ),
      ),
    );
  }
}
