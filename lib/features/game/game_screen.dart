import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/di/injection.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
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

    // return Scaffold(
    //   body: screenHeight > screenWidth
    //       ? VerticalView(
    //           screenHeight: screenHeight,
    //           screenWidth: screenWidth,
    //         )
    //       : HorizontalView(
    //           screenHeight: screenHeight,
    //           screenWidth: screenWidth,
    //         ),
    // );
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return constraints.maxHeight > constraints.maxWidth
            ? VerticalView(
                screenHeight: constraints.maxHeight,
                screenWidth: constraints.maxWidth,
              )
            : HorizontalView(
                screenHeight: constraints.maxHeight,
                screenWidth: constraints.maxWidth,
              );
      }),
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
    final boxWidth = screenWidth / 6;
    final paddingValue = (screenWidth - 4 * boxWidth - 3 * (boxWidth / 5)) / 2;

    return Stack(
      children: [
        const Background(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: boxWidth * 6,
              child: Padding(
                padding: EdgeInsets.all(paddingValue),
                child: GameField(boxWidth: boxWidth),
              ),
            ),
            const StepsWidget(),
            const SizedBox(
              height: 10,
            ),
            const TimerWidget(),
          ],
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
    final boxWidth = screenHeight / 6;
    final paddingHorValue =
        (screenWidth * 0.6 - 4 * boxWidth - 3 * (boxWidth / 5)) / 2;

    return Stack(
      children: [
        const Background(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: boxWidth / 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingHorValue,
                ),
                height: screenHeight,
                width: screenWidth * 0.6,
                child: GameField(boxWidth: boxWidth),
              ),
              SizedBox(
                height: screenHeight,
                width: screenWidth * 0.4,
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
