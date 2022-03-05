import 'package:flup_sudoku/ui/game/components/game_board.dart';
import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameView extends GetView<GameController> {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(36),
            child: GameBoard(),),
      ),
    );
  }
}
