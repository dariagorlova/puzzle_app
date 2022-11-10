import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/core/model/box.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';

class GameField extends StatefulWidget {
  const GameField({super.key});

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  List<BoxWithCoord> listBoxes = <BoxWithCoord>[];
  List<BoxWithCoord> initlistBoxes = <BoxWithCoord>[];
  final startX = 50.0;
  final startY = 50.0;
  final boxWidth = 50;
  final spaceBetweenBoxes = 10;

  @override
  void initState() {
    super.initState();
    final gameData = context.read<GameCubit>().state.numbers;
    listBoxes = context.read<GameCubit>().fillInitialList(
          startX,
          startY,
          boxWidth,
          spaceBetweenBoxes,
          gameData,
        );
    // final gameData = context.read<GameCubit>().state.numbers;
    // for (var i = 0; i < 16; i++) {
    //   var coordX = startX;
    //   var coordY = startY;
    //   if (i >= 0 && i < 4) {
    //     coordX = startX + i * (boxWidth + spaceBetweenBoxes);
    //     coordY = startY;
    //   } else if (i >= 4 && i < 8) {
    //     coordX = startX + (i - 4) * (boxWidth + spaceBetweenBoxes);
    //     coordY = startY + (boxWidth + spaceBetweenBoxes);
    //   } else if (i >= 8 && i < 12) {
    //     coordX = startX + (i - 8) * (boxWidth + spaceBetweenBoxes);
    //     coordY = startY + 2 * (boxWidth + spaceBetweenBoxes);
    //   } else if (i >= 12 && i < 16) {
    //     coordX = startX + (i - 12) * (boxWidth + spaceBetweenBoxes);
    //     coordY = startY + 3 * (boxWidth + spaceBetweenBoxes);
    //   }
    //   listBoxes.add(
    //     BoxWithCoord(
    //       coordX: coordX,
    //       coordY: coordY,
    //       text: gameData[i],
    //     ),
    //   );
    //   initlistBoxes.add(
    //     BoxWithCoord(
    //       coordX: coordX,
    //       coordY: coordY,
    //       text: gameData[i],
    //     ),
    //   );
    //}
  }

  // void swapBoxes(int curNum) {
  //   final curElement =
  //       listBoxes.firstWhere((element) => element.text == curNum);
  //   final curElementIndex =
  //       listBoxes.indexWhere((element) => element == curElement);
  //   final coordMidXcur = curElement.coordX + boxWidth / 2;
  //   final coordMidYcur = curElement.coordY + boxWidth / 2;
  //   final emptyElement = listBoxes.firstWhere((element) => element.text == 16);
  //   final emptyIndex =
  //       listBoxes.indexWhere((element) => element == emptyElement);
  //   final coordMidXempty = emptyElement.coordX + boxWidth / 2;
  //   final coordMidYempty = emptyElement.coordY + boxWidth / 2;
  //   var canSwap = false;
  //   final boxWidthAndSpaceBetween = boxWidth + spaceBetweenBoxes;
  //   // can move current to right
  //   if ((coordMidXcur + boxWidthAndSpaceBetween) == coordMidXempty &&
  //       coordMidYcur == coordMidYempty) {
  //     canSwap = true;
  //   }
  //   // can move current to down
  //   if (coordMidXcur == coordMidXempty &&
  //       (coordMidYcur + boxWidthAndSpaceBetween) == coordMidYempty) {
  //     canSwap = true;
  //   }
  //   // can move current to left
  //   if ((coordMidXcur - boxWidthAndSpaceBetween) == coordMidXempty &&
  //       coordMidYcur == coordMidYempty) {
  //     canSwap = true;
  //   }
  //   // can move current to top
  //   if (coordMidXcur == coordMidXempty &&
  //       (coordMidYcur - boxWidthAndSpaceBetween) == coordMidYempty) {
  //     canSwap = true;
  //   }
  //   if (canSwap) {
  //     listBoxes[curElementIndex] = BoxWithCoord(
  //       coordX: emptyElement.coordX,
  //       coordY: emptyElement.coordY,
  //       text: curElement.text,
  //     );
  //     listBoxes[emptyIndex] = BoxWithCoord(
  //       coordX: curElement.coordX,
  //       coordY: curElement.coordY,
  //       text: emptyElement.text,
  //     );
  //     context.read<GameCubit>().swapedBoxes(listBoxes);
  //   }
  // }

  List<Widget> _buildTiles() => List<Widget>.generate(16, _buildOneTile);

  Widget _buildOneTile(int index) {
    return AnimatedPositioned(
      left: listBoxes[index].coordX,
      top: listBoxes[index].coordY,
      width: boxWidth.toDouble(),
      height: boxWidth.toDouble(),
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: GestureDetector(
        onTap: () {
          setState(() {
            context.read<GameCubit>().swapBoxes(
                  listBoxes[index].text,
                  listBoxes,
                  boxWidth,
                  spaceBetweenBoxes,
                );
            final initList = context.read<GameCubit>().fillInitialList(
                  startX,
                  startY,
                  boxWidth,
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
                    startX,
                    startY,
                    boxWidth,
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
                  width: boxWidth.toDouble(),
                  height: boxWidth.toDouble(),
                  child: Center(
                    child: Text(
                      listBoxes[index].text.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ),
              )
            : Container(
                color: Colors.transparent,
                width: boxWidth.toDouble(),
                height: boxWidth.toDouble(),
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
