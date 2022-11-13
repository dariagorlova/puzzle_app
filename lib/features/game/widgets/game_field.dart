import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzle_app/core/model/box.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/widgets/timer/bloc/timer_bloc.dart';

class GameField extends StatefulWidget {
  const GameField({super.key, required this.boxWidth, required this.startX});

  final int boxWidth;
  final int startX;

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  List<BoxWithCoord> listBoxes = <BoxWithCoord>[];
  List<BoxWithCoord> initlistBoxes = <BoxWithCoord>[];

  final startY = 0;
  int spaceBetweenBoxes = 0;

  @override
  void initState() {
    super.initState();

    final gameData = context.read<GameCubit>().state.numbers;
    spaceBetweenBoxes = widget.boxWidth ~/ 5;
    listBoxes = context.read<GameCubit>().fillInitialList(
          widget.startX,
          startY,
          widget.boxWidth,
          spaceBetweenBoxes,
          gameData,
        );
  }

  List<Widget> _buildTiles() => List<Widget>.generate(16, _buildOneTile);

  Widget _buildOneTile(int index) {
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
            //if (context.read<GameCubit>().state.stepsCount == 0) {
            //  context.read<TimerBloc>().add(TimerStarted(duration: 0));
            //}

            context.read<GameCubit>().swapBoxes(
                  listBoxes[index].text,
                  listBoxes,
                  widget.boxWidth,
                  spaceBetweenBoxes,
                );
            final initList = context.read<GameCubit>().fillInitialList(
                  widget.startX,
                  startY,
                  widget.boxWidth,
                  spaceBetweenBoxes,
                  List<int>.generate(16, (index) => index + 1),
                );
            final res = context.read<GameCubit>().isPuzzleCompleted(
                  initList,
                  listBoxes,
                );
            if (res) {
              context.read<GameCubit>().gameFinished();
              //initState();
              final gameData = context.read<GameCubit>().state.numbers;
              listBoxes = context.read<GameCubit>().fillInitialList(
                    widget.startX,
                    startY,
                    widget.boxWidth,
                    spaceBetweenBoxes,
                    gameData,
                  );
            }
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
                  // color: listBoxes[index].text != 16
                  //     ? Colors.orangeAccent.shade100
                  //     : Colors.transparent,
                  width: widget.boxWidth.toDouble(),
                  height: widget.boxWidth.toDouble(),
                  child: Center(
                    child: Text(
                      listBoxes[index].text.toString(),
                      style: GoogleFonts.merienda(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 35,
                        //fontWeight: FontWeight.w700,
                      ),
                      //style: const TextStyle(color: Colors.black, fontSize: 25),
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
// class GameField extends StatelessWidget {
//   const GameField({required this.gameData, super.key});

//   final List<int> gameData;

//   @override
//   Widget build(BuildContext context) {
//     // recalc coord boxes
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisSpacing: 2,
//         crossAxisSpacing: 2,
//         crossAxisCount: 4,
//       ),
//       shrinkWrap: true,
//       itemCount: gameData.length,
//       itemBuilder: (context, index) {
//         return Center(
//           child: GestureDetector(
//             onTap: () {
//               context.read<GameCubit>().swapParts(index);
//             },
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomLeft,
//                   end: Alignment.topRight,
//                   colors: [
//                     Colors.white,
//                     Colors.blue.shade300,
//                     Colors.blue.shade500
//                   ],
//                   tileMode: TileMode.repeated,
//                 ),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.indigo,
//                     blurRadius: 4,
//                     spreadRadius: 4,
//                   ),
//                 ],
//               ),
//               child: SizedBox(
//                 width: 65,
//                 height: 65,
//                 child: Center(
//                   child: Text(
//                     gameData[index] == 16 ? '' : gameData[index].toString(),
//                     style: const TextStyle(fontSize: 25),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
