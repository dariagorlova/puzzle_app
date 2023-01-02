import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/core/model/box.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';
import 'package:puzzle_app/features/game/widgets/box_widget.dart';

class GameField extends StatefulWidget {
  const GameField({
    super.key,
    required this.boxWidth,
  });

  //final int boxWidth;
  final double boxWidth;

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  @override
  void initState() {
    super.initState();
    context.read<GameCubit>().setBoxSize(widget.boxWidth);
  }

  Widget _buildOneTile(int index, BoxWithCoord box) {
    return AnimatedPositioned(
      left: box.coordX,
      top: box.coordY,
      width: widget.boxWidth.toDouble(),
      height: widget.boxWidth.toDouble(),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: GestureDetector(
        key: Key('box$index'),
        onTap: () {
          context.read<GameCubit>().boxTaped(index);
        },
        child: box.text != 16
            ? BoxWidget(
                text: box.text.toString(),
                width: widget.boxWidth.toDouble(),
              )
            : Container(
                color: Colors.transparent,
                width: widget.boxWidth.toDouble(),
                height: widget.boxWidth.toDouble(),
                child: const Text(''),
              ),
      ),
    );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameCubit, GameState, List<BoxWithCoord>>(
      selector: (state) => state.listBoxes,
      builder: (context, listBoxes) {
        return Stack(
          children: listBoxes
              .asMap()
              .map(
                (index, box) => MapEntry(
                  index,
                  _buildOneTile(index, box),
                ),
              )
              .values
              .toList(),
          //),
        );
      },
    );
  }
}
