import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameCell extends GetView<GameController> {
  const GameCell({required this.row, required this.column, Key? key}) : super(key: key);

  final int row, column;

  Border get _border => controller.isSelected(row, column)
      ? Border.all(color: Colors.red)
      : Border(
          left: BorderSide(color: column == 0 ? Colors.black : Colors.grey.shade700, width: column % 3 == 0 ? 1 : 0.25),
          top: BorderSide(color: row == 0 ? Colors.black : Colors.grey.shade700, width: row % 3 == 0 ? 1 : 0.25),
          right: BorderSide(color: column == 8 ? Colors.black : Colors.grey.shade700, width: (column + 1) % 3 == 0 ? 1 : 0),
          bottom: BorderSide(color: row == 8 ? Colors.black : Colors.grey.shade700, width: (row + 1) % 3 == 0 ? 1 : 0),
        );

  Widget get content {
    final Map<int, GuessMode> cellValue = controller.getCellValue(row, column);
    if (cellValue.values.any((element) => element == GuessMode.insert)) {
      return Text(cellValue.keys.first.toString(), style: style);
    } else {
      return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1),
        itemBuilder: (context, index) {
          final value = cellValue[index + 1];
          return value == null
              ? Container()
              : Text(
                  (index + 1).toString(),
                  style: Get.textTheme.labelSmall?.copyWith(color: value == GuessMode.guess ? Colors.black : Colors.red.shade700),
                  textAlign: TextAlign.center,
                );
        },
      );
    }
  }

  Color? get color {
    switch (controller.contentType(row, column)) {
      case GameCellValueType.wrong:
        return Colors.red.withOpacity(0.3);
      case GameCellValueType.correct:
      default:
        return null;
    }
  }

  TextStyle? get style {
    switch (controller.contentType(row, column)) {
      case GameCellValueType.wrong:
        return Get.textTheme.titleLarge?.copyWith(color: Colors.red.shade900);
      case GameCellValueType.correct:
        return Get.textTheme.titleLarge?.copyWith(color: Colors.green.shade700);
      case GameCellValueType.selected:
        return Get.textTheme.titleLarge?.copyWith(color: Colors.white38);
      default:
        return Get.textTheme.titleLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Obx(() => MaterialButton(
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            elevation: 0,
            padding: EdgeInsets.zero,
            onPressed: controller.gameCellOnPressed(row, column),
            color: color,
            shape: _border,
            child: Center(child: content),
          )),
    );
  }
}

enum GameCellValueType {
  wrong,
  guess,
  antiGuess,
  correct,
  initial,
  selected,
  normal,
}
