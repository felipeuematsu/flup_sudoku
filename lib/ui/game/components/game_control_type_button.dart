import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControlTypeButton extends GetView<GameController> {
  const GameControlTypeButton({required this.guessMode, Key? key}) : super(key: key);

  final GuessMode guessMode;

  Color? get _color {
    if (controller.guessMode != guessMode) return Colors.grey;

    switch (guessMode) {
      case GuessMode.guess:
        return Colors.yellow.shade200;
      case GuessMode.antiGuess:
        return Colors.red.shade200;
      case GuessMode.insert:
        return Colors.white;
    }

  }

  Icon get _icon {
    switch (guessMode) {
      case GuessMode.guess:
        return const Icon(Icons.help_outline);
      case GuessMode.insert:
        return const Icon(Icons.add);
      case GuessMode.antiGuess:
        return const Icon(Icons.close);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          child: MaterialButton(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            color: _color,
            onPressed: () => controller.guessMode = guessMode,
            child: _icon,
          ),
        ));
  }
}
