import 'package:flutter/material.dart';
import 'package:puzzle_app/features/game/widgets/game_field.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    String gameTime = '00:00';
    int stepsCount = 0;
    List<int> numbersData = [
      1,
      2,
      3,
      4,
      5,
      -1,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15
    ];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Time: $gameTime',
                      style: const TextStyle(fontSize: 21),
                    ),
                    Text(
                      'Steps: $stepsCount',
                      style: const TextStyle(fontSize: 21),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                ClipOval(
                  child: ColoredBox(
                    color: Colors.cyan.shade100,
                    child: IconButton(
                        onPressed: () {
                          stepsCount = 0;
                        },
                        iconSize: 40,
                        icon: const Icon(Icons.repeat)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: GameField(
                gameData: numbersData,
                tapNumber: () {
                  stepsCount++;
                  print(stepsCount);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
