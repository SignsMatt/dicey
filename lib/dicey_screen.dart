import 'package:dicey/dice_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiceyScreen extends StatelessWidget {
  const DiceyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 160, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 0, 0),
        centerTitle: true,
        title: Text('DICEY', style: GoogleFonts.coiny(fontSize: 35)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: .center,
            spacing: 40,
            children: [DiceWidget(), DiceWidget()],
          ),
        ),
      ),
    );
  }
}
