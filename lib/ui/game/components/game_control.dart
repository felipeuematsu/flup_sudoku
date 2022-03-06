import 'package:flup_sudoku/ui/game/components/game_control_number_button.dart';
import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControl extends GetView<GameController> {
  const GameControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(onPressed: () => controller.guessMode.value = GuessMode.insert, child: const Icon(Icons.add)),
            MaterialButton(onPressed: () => controller.guessMode.value = GuessMode.guess, child: const Icon(Icons.help_outline)),
            MaterialButton(onPressed: () => controller.guessMode.value = GuessMode.antiGuess, child: const Icon(Icons.close)),
          ]
        ),
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
    );
  }
}
