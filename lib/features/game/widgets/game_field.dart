import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzle_app/core/model/box.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';

class GameField extends StatefulWidget {
  const GameField({super.key, required this.boxWidth, required this.startX});

  final int boxWidth;
  final int startX;

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  @override
  void initState() {
    super.initState();
    context.read<GameCubit>().fillInitialCoordList(
          widget.startX,
          widget.boxWidth + widget.boxWidth ~/ 5,
        );
  }

  List<Widget> _buildTiles() => List<Widget>.generate(16, _buildOneTile);

  Widget _buildOneTile(int index) {
    return BlocSelector<GameCubit, GameState, List<BoxWithCoord>>(
      selector: (state) => state.listBoxes,
      builder: (context, listBoxes) {
        return AnimatedPositioned(
          left: listBoxes[index].coordX,
          top: listBoxes[index].coordY,
          width: widget.boxWidth.toDouble(),
          height: widget.boxWidth.toDouble(),
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (context.read<GameCubit>().state.stepsCount == 0) {
                  context.read<GameCubit>().gameStart();
                }
                context.read<GameCubit>().swapBoxes(
                      index,
                      widget.boxWidth,
                      widget.startX,
                    );
              });
            },
            child: listBoxes[index].text != 16
                ? DecoratedBox(
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
                      width: widget.boxWidth.toDouble(),
                      height: widget.boxWidth.toDouble(),
                      child: Center(
                        child: Text(
                          listBoxes[index].text.toString(),
                          style: GoogleFonts.merienda(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    width: widget.boxWidth.toDouble(),
                    height: widget.boxWidth.toDouble(),
                    child: const Text(''),
                  ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: _buildTiles(),
      ),
    );
  }
}
