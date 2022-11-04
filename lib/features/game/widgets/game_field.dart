import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';

class GameField extends StatelessWidget {
  const GameField({required this.gameData, super.key});

  final List<int> gameData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        crossAxisCount: 4,
      ),
      shrinkWrap: true,
      //physics: NeverScrollablePhysics(),
      itemCount: gameData.length,
      itemBuilder: (context, index) {
        return Center(
          child: GestureDetector(
            onTap: () {
              context.read<GameCubit>().numberPressed(index);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.cyan.shade100,
                  borderRadius: BorderRadius.circular(16)),
              child: SizedBox(
                width: 65,
                height: 65,
                child: Center(
                  child: Text(
                    gameData[index] == -1 ? '' : gameData[index].toString(),
                    style: const TextStyle(fontSize: 25),
                    //textAlign: TextAlign.center,
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
