import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/di/injection.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/localization/localization.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({
    required this.duration,
    super.key,
    required this.steps,
  });

  final String duration;
  final int steps;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GameCubit>(),
      child: CongratulationScreenView(
        duration: duration,
        steps: steps,
      ),
    );
  }
}

class CongratulationScreenView extends StatelessWidget {
  const CongratulationScreenView({
    super.key,
    required this.duration,
    required this.steps,
  });

  final String duration;
  final int steps;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        direction: MediaQuery.of(context).orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        children: [
          const SizedBox(
            height: 60,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('images/cup.png'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResultColumn(
                  durationText: duration,
                  stepsText: steps.toString(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<GameCubit>().newGame();
                    },
                    child: Text(
                      t.playAgain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResultColumn extends StatelessWidget {
  const ResultColumn({
    super.key,
    required this.durationText,
    required this.stepsText,
  });

  final String durationText;
  final String stepsText;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.congratulationText,
          style: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).dialogBackgroundColor,
          ),
        ),
        Text(
          t.yourResultsText,
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).dialogBackgroundColor,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.alarm,
              size: 32,
              color: Theme.of(context).dialogBackgroundColor,
            ),
            Text(
              t.timeText,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).dialogBackgroundColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              durationText,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).dialogBackgroundColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.swap_horiz_rounded,
              size: 32,
              color: Theme.of(context).dialogBackgroundColor,
            ),
            Text(
              t.stepsText,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).dialogBackgroundColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              stepsText,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).dialogBackgroundColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
