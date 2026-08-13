import 'dart:math';

import 'package:dicey/dice_widget.dart';
import 'package:dicey/die_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake/shake.dart';

class DiceyScreen extends StatefulWidget {
  const DiceyScreen({super.key});

  @override
  State<DiceyScreen> createState() => _DiceyScreenState();
}

class _DiceyScreenState extends State<DiceyScreen> {
  List<DieModel> dice = [];
  int nextId = 0;
  ShakeDetector? _detector;

  void rollDie(DieModel die) {
    final index = dice.indexWhere((x) => x.id == die.id);
    final newDie = DieModel(
      id: die.id,
      side: DiceSides.values[Random().nextInt(6)],
    );
    setState(() {
      dice[index] = newDie;
    });
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
            dice.forEach(rollDie);
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 160, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 0, 0),
        centerTitle: true,
        title: Text('DICEY', style: GoogleFonts.coiny(fontSize: 35)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 155, 145),
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () {
          setState(() {
            nextId++;
            final newDie = DieModel(id: nextId, side: DiceSides.one);
            dice.add(newDie);
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox.expand(
          child: Wrap(
            clipBehavior: .none,
            alignment: .center,
            spacing: 40,
            runSpacing: 40,
            children: [
              ...dice.map((x) => DiceWidget(die: x, onTap: () => rollDie(x))),
            ],
          ),
        ),
      ),
    );
  }
}
