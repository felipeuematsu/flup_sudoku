import 'package:flup_sudoku/ui/game/components/game_app_bar.dart';
import 'package:flup_sudoku/ui/game/components/game_board.dart';
import 'package:flup_sudoku/ui/game/components/game_control.dart';
import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameView extends GetView<GameController> {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBar(controller: controller),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const GameBoard(),

            const GameControl(),
          ],
        ),
      ),
    );
  }
}
