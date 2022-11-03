import 'package:flutter/material.dart';

class GameField extends StatelessWidget {
  GameField({required this.gameData, required this.tapNumber, super.key});

  List<int> gameData;
  VoidCallback tapNumber;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        crossAxisCount: 4,
      ),
      shrinkWrap: true,
      //physics: NeverScrollablePhysics(),
      itemCount: gameData.length,
      itemBuilder: (context, index) {
        return Center(
          child: GestureDetector(
            onTap: tapNumber,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.cyan.shade100,
                  borderRadius: BorderRadius.circular(16)),
              child: SizedBox(
                width: 65,
                height: 65,
                child: Center(
                  child: Text(
                    gameData[index] == -1 ? '' : gameData[index].toString(),
                    style: TextStyle(fontSize: 25),
                    //textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
