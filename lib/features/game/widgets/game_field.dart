import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';

class GameField extends StatelessWidget {
  const GameField({required this.gameData, super.key});

  final List<int> gameData;

  @override
  Widget build(BuildContext context) {
    // recalc coord boxes
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        crossAxisCount: 4,
      ),
      shrinkWrap: true,
      itemCount: gameData.length,
      itemBuilder: (context, index) {
        return Center(
          child: GestureDetector(
            onTap: () {
              context.read<GameCubit>().swapParts(index);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.white,
                    Colors.blue.shade300,
                    Colors.blue.shade500
                  ],
                  tileMode: TileMode.repeated,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.indigo,
                    blurRadius: 4,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: SizedBox(
                width: 65,
                height: 65,
                child: Center(
                  child: Text(
                    gameData[index] == 16 ? '' : gameData[index].toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
