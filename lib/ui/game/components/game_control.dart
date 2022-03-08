import 'package:flup_sudoku/ui/game/components/game_control_number_button.dart';
import 'package:flup_sudoku/ui/game/components/game_control_button.dart';
import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControl extends GetView<GameController> {
  const GameControl({Key? key}) : super(key: key);

  static const heightConstants = 2 * GameControlButton.padding + GameControlButton.height + 2 * GameControlNumberButton.padding + 33;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Flexible(flex: 1, child: GameControlButton(type: GameControlType.insert)),
            Flexible(flex: 1, child: GameControlButton(type: GameControlType.guess)),
            Flexible(flex: 1, child: GameControlButton(type: GameControlType.antiGuess)),
            Flexible(flex: 1, child: GameControlButton(type: GameControlType.clear)),
          ]),
          SizedBox(
            height: 2 * context.width / 5,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (int i = 1; i <= 9; i++) GameControlNumberButton(value: i),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
