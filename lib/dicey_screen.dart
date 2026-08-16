import 'dart:math' as math;
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 12.0;

            if (dice.isEmpty) {
              return const SizedBox();
            }

            double bestSize = 0;

            // Try every possible number of columns.
            for (int columns = 1; columns <= dice.length; columns++) {
              final rows = (dice.length / columns).ceil();

              final widthAvailable =
                  constraints.maxWidth - (columns - 1) * spacing;

              final heightAvailable =
                  constraints.maxHeight - (rows - 1) * spacing;

              final sizeFromWidth = widthAvailable / columns;
              final sizeFromHeight = heightAvailable / rows;

              final dieSize = math.min(sizeFromWidth, sizeFromHeight);

              if (dieSize > bestSize) {
                bestSize = dieSize;
              }
            }

            if (bestSize > 200) bestSize = 200;

            return Center(
              child: Wrap(
                alignment: .center,
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  ...dice.map((die) {
                    return SizedBox(
                      width: bestSize,
                      height: bestSize,
                      child: DiceWidget(die: die, onTap: () => rollDie(die)),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
