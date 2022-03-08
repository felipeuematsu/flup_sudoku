import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControlNumberButton extends GetView<GameController> {
  const GameControlNumberButton({required this.value, Key? key}) : super(key: key);

  static const padding = 12.0;
  final int value;

  Color get _color {
    final InsertMode? cellType = controller.selectedCellValue[value];

    if (cellType == null) return Colors.white;

    switch (cellType) {
      case InsertMode.insert:
        return Get.theme.colorScheme.primaryContainer;
      case InsertMode.guess:
        return Get.theme.colorScheme.tertiaryContainer;
      case InsertMode.antiGuess:
        return Get.theme.colorScheme.errorContainer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(padding),
          child: SizedBox.square(
            dimension: context.width / 8,
            child: MaterialButton(
              elevation: controller.gameNumberButtonActivated(value) ? 4 : 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: controller.onNumberButtonPressed(value),
              color: _color,
              disabledColor: _color.withOpacity(0.5),
              highlightColor: Colors.transparent,
              child: FittedBox(
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                  style: Get.textTheme.displaySmall,
                ),
              ),
            ),
          ),
        ));
  }
}
