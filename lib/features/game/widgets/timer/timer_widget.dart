import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/widgets/gradient_button.dart';
import 'package:puzzle_app/features/game/widgets/timer/bloc/timer_bloc.dart';
import 'package:puzzle_app/features/game/widgets/timer/util/ticker.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(child: TimerText()),
          ),
          SizedBox(
            width: 10,
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
        (((duration / 60) % 60).floor() - 1).toString().padLeft(2, '0');
    // ignore: noop_primitive_operations
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headline4,
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
            if (state is TimerInitial) ...[
              // FloatingActionButton(
              //   backgroundColor: Colors.cyan.shade100,
              //   child: const Icon(Icons.play_arrow),
              //   onPressed: () => context
              //       .read<TimerBloc>()
              //       .add(TimerStarted(duration: state.duration)),
              // ),
              GradientButton(
                title: const Icon(Icons.play_arrow),
                funcOnTap: () => context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.duration)),
              ),
            ],
            if (state is TimerRunInProgress) ...[
              // FloatingActionButton(
              //   backgroundColor: Colors.cyan.shade100,
              //   child: const Icon(Icons.pause),
              //   onPressed: () => context.read<TimerBloc>().add(
              //         const TimerPaused(),
              //       ),
              // ),
              GradientButton(
                title: const Icon(Icons.pause),
                funcOnTap: () =>
                    context.read<TimerBloc>().add(const TimerPaused()),
              ),
              const SizedBox(
                width: 10,
              ),
              // FloatingActionButton(
              //   backgroundColor: Colors.cyan.shade100,
              //   child: const Icon(Icons.replay),
              //   onPressed: () {
              //     context.read<TimerBloc>().add(
              //           const TimerReset(),
              //         );
              //     context.read<GameCubit>().restartGame();
              //   },
              // ),
              GradientButton(
                title: const Icon(Icons.replay),
                funcOnTap: () {
                  context.read<TimerBloc>().add(const TimerReset());
                  context.read<GameCubit>().restartGame();
                },
              ),
            ],
            if (state is TimerRunPause) ...[
              // FloatingActionButton(
              //   backgroundColor: Colors.cyan.shade100,
              //   child: const Icon(Icons.play_arrow),
              //   onPressed: () => context.read<TimerBloc>().add(
              //         const TimerResumed(),
              //       ),
              // ),
              GradientButton(
                title: const Icon(Icons.play_arrow),
                funcOnTap: () =>
                    context.read<TimerBloc>().add(const TimerResumed()),
              ),
              const SizedBox(
                width: 10,
              ),
              // FloatingActionButton(
              //   backgroundColor: Colors.cyan.shade100,
              //   child: const Icon(Icons.replay),
              //   onPressed: () => context.read<TimerBloc>().add(
              //         const TimerReset(),
              //       ),
              // ),
              GradientButton(
                title: const Icon(Icons.replay),
                funcOnTap: () =>
                    context.read<TimerBloc>().add(const TimerReset()),
              ),
            ],
            // if (state is TimerRunComplete) ...[
            //   FloatingActionButton(
            //     backgroundColor: Colors.cyan.shade100,
            //     child: const Icon(Icons.replay),
            //     onPressed: () => context.read<TimerBloc>().add(
            //           const TimerReset(),
            //         ),
            //   ),
            //]
          ],
        );
      },
    );
  }
}
