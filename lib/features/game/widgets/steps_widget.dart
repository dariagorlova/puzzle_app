import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';
import 'package:puzzle_app/localization/localization.dart';

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
          style: GoogleFonts.merienda(
            textStyle: Theme.of(context).textTheme.headlineMedium,
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
        );
      },
    );
  }
}
