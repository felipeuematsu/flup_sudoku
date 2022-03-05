import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameCell extends GetView<GameController> {
  const GameCell({required this.row, required this.column, Key? key}) : super(key: key);

  final int row, column;

  Border get _border => Border(
        left: BorderSide(color: column == 0 ? Colors.black : Colors.grey.shade700, width: column % 3 == 0 ? 1 : 0.25),
        top: BorderSide(color: row == 0 ? Colors.black : Colors.grey.shade700, width: row % 3 == 0 ? 1 : 0.25),
        right: BorderSide(color: column == 8 ? Colors.black : Colors.grey.shade700, width: (column + 1) % 3 == 0 ? 1 : 0),
        bottom: BorderSide(color: row == 8 ? Colors.black : Colors.grey.shade700, width: (row + 1) % 3 == 0 ? 1 : 0),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: ,
      height: double.infinity,
      width: double.infinity,
      child: Obx(() => MaterialButton(
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            elevation: 0,
            padding: EdgeInsets.zero,
            onPressed: controller.select(row, column),
            // color: (row + 1) / 3 == (column+ 1) / 3 ? Colors.transparent : Colors.green.withOpacity(.3),
            shape: _border,
            child: Center(
              // child: Text('1 2 3\n4 5 6\n7 8 9', style: Get.textTheme.labelSmall),
              child: Text('1', style: Get.textTheme.titleLarge?.copyWith(color: controller.isSelected(row, column) ? Colors.white : Colors.black)),
            ),
          )),
    );
  }
}
