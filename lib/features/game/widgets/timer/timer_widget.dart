import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';
import 'package:puzzle_app/features/game/widgets/gradient_button.dart';
import 'package:puzzle_app/features/game/widgets/timer/bloc/timer_bloc.dart';
import 'package:puzzle_app/features/game/widgets/timer/util/ticker.dart';
import 'package:puzzle_app/localization/localization.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(child: TimerText()),
          SizedBox(
            height: 20,
          ),
          Actions(),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        (((duration / 60) % 60).floor() - 600).toString().padLeft(2, '0');

    // ignore: noop_primitive_operations
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '${AppLocalizations.of(context).timeText}: $minutesStr:$secondsStr',
      //style: Theme.of(context).textTheme.headline4,
      style: GoogleFonts.merienda(
        textStyle: Theme.of(context).textTheme.headline4,
        fontSize: 35,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocListener<GameCubit, GameState>(
              listenWhen: (previous, current) =>
                  !previous.gameHasBegun && current.gameHasBegun,
              listener: (context, state) {
                if (state.gameHasBegun) {
                  context
                      .read<TimerBloc>()
                      .add(const TimerStarted(duration: 600));
                }
              },
              child: GradientButton(
                title: const Icon(Icons.replay),
                funcOnTap: () {
                  context.read<TimerBloc>().add(const TimerReset());
                  context.read<GameCubit>().restartGame();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// class Actions extends StatelessWidget {
//   const Actions({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<GameCubit, GameState>(
//       listenWhen: (previous, current) =>
//           !previous.gameHasBegun && current.gameHasBegun,
//       listener: (context, state) {
//         if (state.gameHasBegun) {
//           context.read<TimerBloc>().add(const TimerStarted(duration: 0));
//         } else {
//           context.read<TimerBloc>().add(const TimerPaused());
//         }
//       },
//       child: BlocBuilder<TimerBloc, TimerState>(
//         buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
//         builder: (context, state) {
//           return Row(
//             children: [
//               GradientButton(
//                 title: const Icon(Icons.play_arrow),
//                 funcOnTap: () =>
//                     context.read<TimerBloc>().add(TimerStarted(duration: 0)),
//               ),
//               GradientButton(
//                 title: const Icon(Icons.replay),
//                 funcOnTap: () {
//                   context.read<TimerBloc>().add(const TimerReset());
//                   context.read<GameCubit>().restartGame();
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// WORK VERSION, DON'T TOUCH
// class Actions extends StatelessWidget {
//   const Actions({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TimerBloc, TimerState>(
//       buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
//       builder: (context, state) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             if (state is TimerInitial) ...[
//               GradientButton(
//                 title: const Icon(Icons.play_arrow),
//                 funcOnTap: () => context
//                     .read<TimerBloc>()
//                     .add(TimerStarted(duration: state.duration)),
//               ),
//             ],
//             if (state is TimerRunInProgress) ...[
//               GradientButton(
//                 title: const Icon(Icons.pause),
//                 funcOnTap: () =>
//                     context.read<TimerBloc>().add(const TimerPaused()),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               GradientButton(
//                 title: const Icon(Icons.replay),
//                 funcOnTap: () {
//                   context.read<TimerBloc>().add(const TimerReset());
//                   context.read<GameCubit>().restartGame();
//                 },
//               ),
//             ],
//             if (state is TimerRunPause) ...[
//               GradientButton(
//                 title: const Icon(Icons.play_arrow),
//                 funcOnTap: () =>
//                     context.read<TimerBloc>().add(const TimerResumed()),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               GradientButton(
//                 title: const Icon(Icons.replay),
//                 funcOnTap: () =>
//                     context.read<TimerBloc>().add(const TimerReset()),
//               ),
//             ],
//             // if (state is TimerRunComplete) ...[
//             //   FloatingActionButton(
//             //     backgroundColor: Colors.cyan.shade100,
//             //     child: const Icon(Icons.replay),
//             //     onPressed: () => context.read<TimerBloc>().add(
//             //           const TimerReset(),
//             //         ),
//             //   ),
//             //]
//           ],
//         );
//       },
//     );
//   }
// }
