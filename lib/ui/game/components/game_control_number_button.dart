import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControlNumberButton extends GetView<GameController> {
  const GameControlNumberButton({required this.value, Key? key}) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Obx(() => MaterialButton(
           focusElevation: 50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: controller.onNumberButtonPressed(value),
          color: controller.selectedCellValue == value.toString() ? Colors.grey : Colors.white,
          child: Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: Get.textTheme.displaySmall,
          ),
        ));
  }
}
