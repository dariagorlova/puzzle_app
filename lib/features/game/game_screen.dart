import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/di/injection.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';
import 'package:puzzle_app/features/game/widgets/background.dart';
import 'package:puzzle_app/features/game/widgets/game_field.dart';
import 'package:puzzle_app/features/game/widgets/steps_widget.dart';
import 'package:puzzle_app/features/game/widgets/timer/timer_widget.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body:
          // BlocListener<GameCubit, GameState>(
          //   listenWhen: (previous, current) =>
          //       !previous.playerWin && current.playerWin,
          //   listener: (context, state) async {
          //     // final gameDuration = context.read<GameCubit>().getGameDuration();
          //     // await showAlertDialog(
          //     //   context,
          //     //   gameDuration,
          //     //   state.stepsCount as int,
          //     // );
          //     if (mounted) context.read<GameCubit>().restartGame();
          //   },
          //   child:
          //Stack(
          //  children: [
          //    const Background(),
          screenHeight > screenWidth
              ? VerticalView(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                )
              : HorizontalView(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
      //  ],
      //),
      //),
    );
  }
}

class VerticalView extends StatelessWidget {
  const VerticalView({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final boxWidth = screenWidth ~/ 6;
    final startX =
        ((screenWidth - 40) / 2 - 2 * boxWidth - 1.5 * (boxWidth / 5)).toInt();

    return Stack(
      children: [
        const Background(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: boxWidth * 6, //screenHeight / 2, //450,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: BlocSelector<GameCubit, GameState, List<int>>(
                    selector: (state) => state.numbers,
                    builder: (context, numbersData) {
                      return GameField(
                        startX: startX,
                        boxWidth: boxWidth,
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: const [
                    StepsWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    TimerWidget(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       '${AppLocalizations.of(context).timeText}: ',
                    //       //style: const TextStyle(fontSize: 21),
                    //       style: GoogleFonts.merienda(
                    //         textStyle: Theme.of(context).textTheme.headline4,
                    //         fontSize: 35,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //     const TimerWidget(),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HorizontalView extends StatelessWidget {
  const HorizontalView({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final boxWidth = screenHeight ~/ 6;
    final startX =
        ((screenHeight - 40) / 2 - 2 * boxWidth - 1.5 * (boxWidth / 5)).toInt();

    return Stack(
      children: [
        const Background(),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                height: screenHeight,
                width: boxWidth * 6, //screenWidth / 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: BlocSelector<GameCubit, GameState, List<int>>(
                    selector: (state) => state.numbers,
                    builder: (context, numbersData) {
                      return GameField(
                        startX: startX,
                        boxWidth: boxWidth,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: const [
                    StepsWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    TimerWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class TimeStepsColumn extends StatelessWidget {
//   const TimeStepsColumn({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: const [
//         //TimeWidget(),
//         TimerWidget(),
//         SizedBox(
//           height: 30,
//         ),
//         StepsWidget(),
//       ],
//     );
//   }
// }

// class StepsWidget extends StatelessWidget {
//   const StepsWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final t = AppLocalizations.of(context);
//     return BlocSelector<GameCubit, GameState, int>(
//       selector: (state) => state.stepsCount as int,
//       builder: (context, stepsCount) {
//         return Text(
//           '${t.stepsText}: $stepsCount',
//           style: GoogleFonts.merienda(
//             textStyle: Theme.of(context).textTheme.headline4,
//             fontSize: 35,
//             fontWeight: FontWeight.w700,
//           ),
//         );
//       },
//     );
//   }
// }

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
