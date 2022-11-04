import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/di/injection.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';
import 'package:puzzle_app/features/game/widgets/game_field.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GameCubit>(),
      child: const _GameScreen(),
    );
  }
}

class _GameScreen extends StatefulWidget {
  const _GameScreen({super.key});

  @override
  State<_GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<_GameScreen> {
  @override
  Widget build(BuildContext context) {
    const gameTime = '00:00';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TimeStepsColumn(gameTime: gameTime),
                const SizedBox(
                  width: 20,
                ),
                ClipOval(
                  child: ColoredBox(
                    color: Colors.cyan.shade100,
                    child: IconButton(
                        onPressed: () {
                          context.read<GameCubit>().restartGame();
                        },
                        iconSize: 40,
                        icon: const Icon(Icons.repeat)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 450,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: BlocSelector<GameCubit, GameState, List<int>>(
                  selector: (state) => state.numbers,
                  builder: (context, numbersData) {
                    return GameField(
                      gameData: numbersData,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeStepsColumn extends StatelessWidget {
  const TimeStepsColumn({
    super.key,
    required this.gameTime,
  });

  final String gameTime;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameCubit, GameState, int>(
      selector: (state) => state.stepsCount as int,
      builder: (context, stepsCount) {
        return Column(
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
        );
      },
    );
  }
}
