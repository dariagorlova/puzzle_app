import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';
import 'package:puzzle_app/features/game/widgets/gradient_button.dart';
import 'package:puzzle_app/features/game/widgets/timer/bloc/timer_bloc.dart';
import 'package:puzzle_app/features/game/widgets/timer/util/ticker.dart';
import 'package:puzzle_app/localization/localization.dart';

const gameDuration = 600;

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
    final duration = context.select((TimerBloc bloc) => bloc.state.duration) - gameDuration;

    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');

    // ignore: noop_primitive_operations
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '${AppLocalizations.of(context).timeText}: $minutesStr:$secondsStr',
      style: GoogleFonts.merienda(
        textStyle: Theme.of(context).textTheme.headlineMedium,
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
        return BlocListener<GameCubit, GameState>(
          listenWhen: (previous, current) => !previous.gameHasBegun && current.gameHasBegun,
          listener: (context, state) {
            if (state.gameHasBegun) {
              context.read<TimerBloc>().add(const TimerStarted(duration: gameDuration));
            }
          },
          child: BlocListener<GameCubit, GameState>(
            listenWhen: (previous, current) => !previous.playerWin && current.playerWin,
            listener: (context, state) {
              if (state.playerWin) {
                context.read<TimerBloc>().add(const TimerReset());
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
        );
      },
    );
  }
}
