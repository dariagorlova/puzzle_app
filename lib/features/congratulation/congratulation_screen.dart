import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzle_app/di/injection.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/widgets/gradient_button.dart';
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
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     context.read<GameCubit>().newGame();
                  //   },
                  //   child: Text(
                  //     t.playAgain,
                  //   ),
                  // ),
                  child: GradientButton(
                    // title: Text(
                    //   t.playAgain,
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.merienda(
                    //     textStyle: Theme.of(context).textTheme.titleSmall,
                    //     color: Colors.white,
                    //     //fontSize: 35,
                    //     //fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    title: Icon(
                      Icons.replay,
                      color: Theme.of(context).dialogBackgroundColor,
                    ),
                    funcOnTap: () {
                      context.read<GameCubit>().newGame();
                    },
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
          style: GoogleFonts.merienda(
            textStyle: Theme.of(context).textTheme.headline3,
            //fontSize: 35,
            color: Theme.of(context).dialogBackgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          '${t.yourResultsText}:',
          style: GoogleFonts.merienda(
            textStyle: Theme.of(context).textTheme.headline5,
            //fontSize: 27,
            color: Theme.of(context).cardColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.alarm,
              size: 32,
              color: Theme.of(context).cardColor,
            ),
            Text(
              t.timeText,
              // style: TextStyle(
              //   fontSize: 27,
              //   fontWeight: FontWeight.bold,
              //   color: Theme.of(context).dialogBackgroundColor,
              // ),
              style: GoogleFonts.merienda(
                textStyle: Theme.of(context).textTheme.headline5,
                //fontSize: 27,
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              durationText,
              style: GoogleFonts.merienda(
                textStyle: Theme.of(context).textTheme.headline5,
                //fontSize: 27,
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w700,
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
              color: Theme.of(context).cardColor,
            ),
            Text(
              t.stepsText,
              style: GoogleFonts.merienda(
                textStyle: Theme.of(context).textTheme.headline5,
                //fontSize: 27,
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              stepsText,
              style: GoogleFonts.merienda(
                textStyle: Theme.of(context).textTheme.headline5,
                //fontSize: 27,
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
