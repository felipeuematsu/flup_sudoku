import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameCell extends GetView<GameController> {
  const GameCell({required this.row, required this.column, Key? key}) : super(key: key);

  final int row, column;

  Border get _border => controller.isSelected(row, column)
      ? Border.all(color: Get.theme.colorScheme.tertiary)
      : Border(
          left: BorderSide(
            color: Get.theme.colorScheme.outline.withOpacity(column % 3 == 0 ? 1 : .3),
            style: column == 0 ? BorderStyle.none : BorderStyle.solid,
          ),
          top: BorderSide(
            color: Get.theme.colorScheme.outline.withOpacity(row % 3 == 0 ? 1 : .3),
            style: row == 0 ? BorderStyle.none : BorderStyle.solid,
          ),
          right: const BorderSide(style: BorderStyle.none),
          bottom: const BorderSide(style: BorderStyle.none),
        );

  Widget get content {
    final cellValue = controller.getCellValue(row, column);

    if (cellValue.values.any((element) => element == InsertMode.insert)) {
      final filtered = cellValue..removeWhere((key, value) => value != InsertMode.insert);

      return Text(filtered.keys.first.toString(), style: style);
    }
    if (cellValue.isEmpty) return Container();

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1),
      itemBuilder: (context, index) {
        final value = cellValue[index + 1];
        return value == null
            ? Container()
            : Text(
                (index + 1).toString(),
                style: Get.textTheme.labelSmall?.copyWith(color: value == InsertMode.guess ? Colors.black : Colors.red.shade700),
                textAlign: TextAlign.center,
              );
      },
    );
  }

  Color? get color {
    switch (controller.getContentType(row, column)) {
      case GameCellValueType.wrong:
        return Colors.red.withOpacity(0.3);
      case GameCellValueType.correct:
      default:
        return null;
    }
  }

  TextStyle? get style {
    switch (controller.getContentType(row, column)) {
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
            onPressed: controller.onGameCellPressed(row, column),
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
