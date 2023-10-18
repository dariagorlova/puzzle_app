import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.funcOnTap,
    required this.title,
    super.key,
  });

  final void Function() funcOnTap;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcOnTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36), // 16
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.white,
              Colors.blue.shade300,
              Colors.blue.shade500,
            ],
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
          width: 50, // 65
          height: 50, // 65
          child: Center(
            child: title,
            // child: Text(
            //   title,
            //   style: const TextStyle(fontSize: 25),
            // ),
          ),
        ),
      ),
    );
  }
}
