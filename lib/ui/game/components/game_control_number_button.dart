import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControlNumberButton extends GetView<GameController> {
  const GameControlNumberButton({required this.value, Key? key}) : super(key: key);

  final int value;

  Color get _color {
    final InsertMode? cellType = controller.selectedCellValue[value];

    if (cellType == null) return Colors.white;

    switch (cellType) {
      case InsertMode.guess:
        return Colors.green.shade700;
      case InsertMode.insert:
        return Colors.grey;
      case InsertMode.antiGuess:
        return Colors.red.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox.square(
      dimension: context.width / 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: MaterialButton(
              focusElevation: 50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: controller.onNumberButtonPressed(value),
              color: _color,
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: Get.textTheme.displaySmall,
              ),
            ),
      ),
    ));
  }
}
