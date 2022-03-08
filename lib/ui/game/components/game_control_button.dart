import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControlButton extends GetView<GameController> {
  const GameControlButton({required this.type, Key? key}) : super(key: key);

  final GameControlType type;

  static const padding = 4.0;
  static const height = 36.0;

  Color get _color {
    switch (type) {
      case GameControlType.guess:
        return Get.theme.colorScheme.secondaryContainer;
      case GameControlType.antiGuess:
        return Get.theme.colorScheme.secondaryContainer;
      case GameControlType.insert:
        return Get.theme.colorScheme.secondaryContainer;
      default:
        return Get.theme.colorScheme.onSurfaceVariant;
    }
  }

  Color? get _disabledColor {
    switch (type) {
      case GameControlType.guess:
        return Get.theme.colorScheme.secondaryContainer.withOpacity(0.5);
      case GameControlType.antiGuess:
        return Get.theme.colorScheme.secondaryContainer.withOpacity(0.5);
      case GameControlType.insert:
        return Get.theme.colorScheme.secondaryContainer.withOpacity(0.5);
      default:
        return Get.theme.colorScheme.onSurfaceVariant.withOpacity(0.5);
    }
  }

  Icon get _icon {
    switch (type) {
      case GameControlType.guess:
        return const Icon(Icons.edit);
      case GameControlType.insert:
        return const Icon(Icons.add);
      case GameControlType.antiGuess:
        return const Icon(Icons.edit, color: Colors.redAccent,);
      case GameControlType.clear:
        return const Icon(Icons.clear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(padding),
        child: Obx(
          () => MaterialButton(
            height: height,
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
