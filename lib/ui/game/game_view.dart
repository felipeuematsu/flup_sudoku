import 'package:flup_sudoku/ui/game/components/game_board.dart';
import 'package:flup_sudoku/ui/game/components/game_control.dart';
import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flup_sudoku/ui/game/game_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Text('${GameStrings.id.tr} ${controller.model.id}'),
                          onTap: () => Clipboard.setData(ClipboardData(text: controller.model.id.toString())),
                        ),
                        Obx(() => Text('${GameStrings.time.tr} ${controller.elapsedTime}')),
                        Obx(() => Text('${GameStrings.mistakes.tr} ${controller.mistakes}')),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height - 2 * context.width / 5 - GameControl.heightConstants,
                      ),
                      child: const GameBoard(),
                    ),
                  ],
                ),
              ),
            ),
            const GameControl(),
          ],
        ),
      ),
    );
  }
}
