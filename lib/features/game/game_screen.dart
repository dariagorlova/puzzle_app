import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/di/injection.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';
import 'package:puzzle_app/features/game/widgets/alert_dialog.dart';
import 'package:puzzle_app/features/game/widgets/background.dart';
import 'package:puzzle_app/features/game/widgets/game_field.dart';
import 'package:puzzle_app/features/game/widgets/timer/timer_widget.dart';
import 'package:puzzle_app/localization/localization.dart';

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
  const _GameScreen();

  @override
  State<_GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<_GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GameCubit, GameState>(
        listenWhen: (previous, current) =>
            !previous.playerWin && current.playerWin,
        listener: (context, state) async {
          final gameDuration = context.read<GameCubit>().getGameDuration();
          await showAlertDialog(
            context,
            gameDuration,
            state.stepsCount as int,
          );
          if (mounted) context.read<GameCubit>().restartGame();
        },
        child: Stack(
          children: [
            const Background(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${AppLocalizations.of(context).timeText}: ',
                        style: const TextStyle(fontSize: 21),
                      ),
                      const TimerWidget(),
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
                  const Center(
                    child: StepsWidget(),
                  ),
                ],
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        //TimeWidget(),
        TimerWidget(),
        SizedBox(
          height: 30,
        ),
        StepsWidget(),
      ],
    );
  }
}

class StepsWidget extends StatelessWidget {
  const StepsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocSelector<GameCubit, GameState, int>(
      selector: (state) => state.stepsCount as int,
      builder: (context, stepsCount) {
        return Text(
          '${t.stepsText}: $stepsCount',
          style: const TextStyle(fontSize: 21),
        );
      },
    );
  }
}

// class TimeWidget extends StatelessWidget {
//   const TimeWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UpdatetimerCubit, UpdatetimerState>(
//       bloc: UpdatetimerCubit(),
//       builder: (context, state) {
//         if (state is UpdatetimerUIState) {
//           return Column(
//             children: [
//               TextButton(
//                 onPressed: () {},
//                 child: Text('Reset'),
//               ),
//               Text('${state.currentTime}'),
//             ],
//           );
//         }
//         //return Text('${DateTime.now().millisecondsSinceEpoch}');
//         return Text('${DateTime.now().millisecondsSinceEpoch}');
//       },
//     );
//   }
// }

// class UpdatetimerCubit extends Cubit<UpdatetimerState> {
//   Timer? timer;
//   UpdatetimerCubit() : super(UpdatetimerInitial()) {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       print('Timer');
//       emit(UpdatetimerUIState(DateTime.now().millisecondsSinceEpoch));
//     });
//   }
//   void closeTimer() {
//     timer?.cancel();
//   }
// }

// @immutable
// abstract class UpdatetimerState {}

// class UpdatetimerInitial extends UpdatetimerState {}

// class UpdatetimerUIState extends UpdatetimerState {
//   final int currentTime;

//   UpdatetimerUIState(this.currentTime);
// }
