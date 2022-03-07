import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControlButton extends GetView<GameController> {
  const GameControlButton({required this.type, Key? key}) : super(key: key);

  final GameControlType type;

  Color get _color {
    switch (type) {
      case GameControlType.guess:
        return Colors.yellow.shade200;
      case GameControlType.antiGuess:
        return Colors.red.shade200;
      case GameControlType.insert:
        return Colors.blue.shade200;
      default:
        return Colors.blueGrey.shade200;
    }
  }
  Color? get _disabledColor {
    switch (type) {
      case GameControlType.guess:
        return Colors.yellow.shade100;
      case GameControlType.antiGuess:
        return Colors.red.shade100;
      case GameControlType.insert:
        return Colors.blue.shade100;
      case GameControlType.clear:
        return Colors.blueGrey.shade100;
    }
  }

  Icon get _icon {
    switch (type) {
      case GameControlType.guess:
        return const Icon(Icons.help_outline);
      case GameControlType.insert:
        return const Icon(Icons.add);
      case GameControlType.antiGuess:
        return const Icon(Icons.warning);
      case GameControlType.clear:
        return const Icon(Icons.clear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        child: Obx(
          () => MaterialButton(
            disabledColor: _disabledColor,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            color: _color,
            onPressed: controller.onGameControlButtonPressed(type),
            child: _icon,
          ),
        ));
  }
}

enum GameControlType {
  guess,
  antiGuess,
  insert,
  clear,
}
