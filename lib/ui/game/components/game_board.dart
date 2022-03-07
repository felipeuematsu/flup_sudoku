import 'package:flup_sudoku/ui/game/components/game_cell.dart';
import 'package:flup_sudoku/ui/game/controller/game_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameBoard extends GetView<GameAnimationController> {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columnWidth = constraints.maxWidth / 9;
          final rowHeight = constraints.maxHeight / 9;

          return Stack(
            children: [
              AnimatedBuilder(
                animation: controller.verticalAnimation,
                builder: (_, __) => Transform(
                  transform: Matrix4.identity()..translate(0.0, controller.verticalAnimation.value * rowHeight),
                  child: Container(height: rowHeight, color: controller.verticalAnimation.value < 0 ? null : Colors.grey.shade600.withOpacity(.5)),
                ),
              ),
              AnimatedBuilder(
                animation: controller.horizontalAnimation,
                builder: (_, __) => Transform(
                  transform: Matrix4.identity()..translate((controller.horizontalAnimation.value) * columnWidth),
                  child: Container(width: columnWidth, color: controller.horizontalAnimation.value < 0 ? null : Colors.grey.shade600.withOpacity(.5)),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade600, width: 1)),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 9, childAspectRatio: 1, crossAxisSpacing: 0, mainAxisSpacing: 0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 9 * 9,
                    itemBuilder: (context, index) => GameCell(row: index ~/ 9, column: index % 9),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
