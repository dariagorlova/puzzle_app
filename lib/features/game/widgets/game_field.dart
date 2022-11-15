import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzle_app/core/model/box.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';
import 'package:puzzle_app/features/game/widgets/timer/bloc/timer_bloc.dart';

class GameField extends StatefulWidget {
  const GameField({super.key, required this.boxWidth, required this.startX});

  final int boxWidth;
  final int startX;

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  //List<BoxWithCoord> listBoxes = <BoxWithCoord>[];
  //List<BoxWithCoord> initlistBoxes = <BoxWithCoord>[];

  //final startY = 0;
  int spaceBetweenBoxes = 0;

  @override
  void initState() {
    super.initState();
    context.read<GameCubit>().fillInitialCoordList_new(
          widget.startX,
          widget.boxWidth,
        );

    // final gameData = context.read<GameCubit>().state.numbers;
    // spaceBetweenBoxes = widget.boxWidth ~/ 5;
    // context.read<GameCubit>().fillInitialCoordList(
    //       widget.startX,
    //       0,
    //       widget.boxWidth,
    //       spaceBetweenBoxes,
    //       gameData,
    //     );
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

                context.read<GameCubit>().swapBoxes_new(
                      index,
                      widget.boxWidth,
                      widget.startX,
                    );
                // context.read<GameCubit>().swapBoxes(
                //       listBoxes[index].text,
                //       listBoxes,
                //       widget.boxWidth,
                //       spaceBetweenBoxes,
                //     );
                // final initList =
                //     context.read<GameCubit>().fillInitialCoordListEmpty(
                //           widget.startX,
                //           startY,
                //           widget.boxWidth,
                //           spaceBetweenBoxes,
                //           List<int>.generate(16, (index) => index + 1),
                //         );
                // final res = context.read<GameCubit>().isPuzzleCompleted(
                //       initList,
                //       listBoxes,
                //     );
                // if (res) {
                //   context.read<GameCubit>().gameFinished();
                //   final gameData = context.read<GameCubit>().state.numbers;
                //   context.read<GameCubit>().fillInitialCoordList(
                //         widget.startX,
                //         startY,
                //         widget.boxWidth,
                //         spaceBetweenBoxes,
                //         gameData,
                //       );
                // }
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

// class _GameFieldState extends State<GameField> {
//   List<BoxWithCoord> listBoxes = <BoxWithCoord>[];
//   List<BoxWithCoord> initlistBoxes = <BoxWithCoord>[];

//   final startY = 0;
//   int spaceBetweenBoxes = 0;

//   @override
//   void initState() {
//     super.initState();

//     final gameData = context.read<GameCubit>().state.numbers;
//     spaceBetweenBoxes = widget.boxWidth ~/ 5;
//     listBoxes = context.read<GameCubit>().fillInitialCoordList(
//           widget.startX,
//           startY,
//           widget.boxWidth,
//           spaceBetweenBoxes,
//           gameData,
//         );
//   }

//   List<Widget> _buildTiles() => List<Widget>.generate(16, _buildOneTile);

//   Widget _buildOneTile(int index) {
//     return AnimatedPositioned(
//       left: listBoxes[index].coordX,
//       top: listBoxes[index].coordY,
//       width: widget.boxWidth.toDouble(),
//       height: widget.boxWidth.toDouble(),
//       duration: const Duration(seconds: 1),
//       curve: Curves.fastOutSlowIn,
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             if (context.read<GameCubit>().state.stepsCount == 0) {
//               //context.read<TimerBloc>().add(const TimerStarted(duration: 0));
//               context.read<GameCubit>().gameStart();
//             }

//             context.read<GameCubit>().swapBoxes(
//                   listBoxes[index].text,
//                   listBoxes,
//                   widget.boxWidth,
//                   spaceBetweenBoxes,
//                 );
//             final initList = context.read<GameCubit>().fillInitialCoordList(
//                   widget.startX,
//                   startY,
//                   widget.boxWidth,
//                   spaceBetweenBoxes,
//                   List<int>.generate(16, (index) => index + 1),
//                 );
//             final res = context.read<GameCubit>().isPuzzleCompleted(
//                   initList,
//                   listBoxes,
//                 );
//             if (res) {
//               context.read<GameCubit>().gameFinished();
//               //initState();
//               final gameData = context.read<GameCubit>().state.numbers;
//               listBoxes = context.read<GameCubit>().fillInitialCoordList(
//                     widget.startX,
//                     startY,
//                     widget.boxWidth,
//                     spaceBetweenBoxes,
//                     gameData,
//                   );
//             }
//           });
//         },
//         child: listBoxes[index].text != 16
//             ? DecoratedBox(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomLeft,
//                     end: Alignment.topRight,
//                     colors: [
//                       Colors.white,
//                       Colors.blue.shade300,
//                       Colors.blue.shade500
//                     ],
//                     tileMode: TileMode.repeated,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.indigo,
//                       blurRadius: 4,
//                       spreadRadius: 4,
//                     ),
//                   ],
//                 ),
//                 child: SizedBox(
//                   // color: listBoxes[index].text != 16
//                   //     ? Colors.orangeAccent.shade100
//                   //     : Colors.transparent,
//                   width: widget.boxWidth.toDouble(),
//                   height: widget.boxWidth.toDouble(),
//                   child: Center(
//                     child: Text(
//                       listBoxes[index].text.toString(),
//                       style: GoogleFonts.merienda(
//                         textStyle: Theme.of(context).textTheme.headline4,
//                         fontSize: 35,
//                         //fontWeight: FontWeight.w700,
//                       ),
//                       //style: const TextStyle(color: Colors.black, fontSize: 25),
//                     ),
//                   ),
//                 ),
//               )
//             : Container(
//                 color: Colors.transparent,
//                 width: widget.boxWidth.toDouble(),
//                 height: widget.boxWidth.toDouble(),
//                 child: const Text(''),
//               ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Stack(
//         children: _buildTiles(),
//       ),
//     );
//   }
// }


