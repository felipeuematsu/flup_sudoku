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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Id: ${controller.model.id}'),
                        Obx(() => Text('Mistakes: ${controller.mistakes}')),
                      ],
                    ),
                    GameBoard(),
                  ],
                ),
              ),
            ),
            GameControl(),
          ],
        ),
      ),
    );
  }
}
