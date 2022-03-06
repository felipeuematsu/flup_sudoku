import 'package:flup_sudoku/ui/game/components/game_control_number_button.dart';
import 'package:flup_sudoku/ui/game/components/game_control_type_button.dart';
import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControl extends GetView<GameController> {
  const GameControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Flexible(flex: 1, child: GameControlTypeButton(guessMode: GuessMode.insert)),
            Flexible(flex: 1, child: GameControlTypeButton(guessMode: GuessMode.guess)),
            Flexible(flex: 1, child: GameControlTypeButton(guessMode: GuessMode.antiGuess)),
          ]),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemExtent: context.width / 9,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: 9,
              itemBuilder: (context, index) => GameControlNumberButton(value: index + 1),
            ),
          ),
        ],
      ),
    );
  }
}
