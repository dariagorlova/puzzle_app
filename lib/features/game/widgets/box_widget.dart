import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    required this.text,
    required this.width,
  });

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.white, Colors.blue.shade300, Colors.blue.shade500],
          tileMode: TileMode.repeated,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.indigo,
            blurRadius: 4,
            spreadRadius: 4,
          ),
        ],
      ),
      child: SizedBox(
        width: width,
        height: width,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.merienda(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }
}
