import 'package:flup_sudoku/ui/game/components/game_board.dart';
import 'package:flup_sudoku/ui/game/components/game_control.dart';
import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameView extends GetView<GameController> {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.all(36), child: Obx(() => Text('Mistakes: ${controller.mistakes}'))),
                  const Padding(
                    padding: EdgeInsets.all(36),
                    child: GameBoard(),
                  ),
                ],
              ),
            ),
            const Positioned(bottom: 0, right: 0, left: 0, child: GameControl()),
          ],
        ),
      ),
    );
  }
}
