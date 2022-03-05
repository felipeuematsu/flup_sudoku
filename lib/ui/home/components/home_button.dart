import 'package:flup_sudoku/ui/home/home_controller.dart';
import 'package:flup_sudoku/ui/home/home_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeButton extends GetView<HomeController> {
  const HomeButton({Key? key, required this.type}) : super(key: key);

  final HomeButtonType type;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: type.color.withOpacity(0.13),
      minWidth: context.width * 0.8,
      onPressed: () => controller.onButtonPress(type),
      child: Text(
        type.text,
        style: Get.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: type.color,
        ),
      ),
    );
  }
}

enum HomeButtonType {
  newGame,
  loadGame,
  settings,
  about,
  liked,
}

extension on HomeButtonType {
  String get text {
    switch (this) {
      case HomeButtonType.newGame:
        return HomeStrings.newGame.tr;
      case HomeButtonType.loadGame:
        return HomeStrings.loadGame.tr;
      case HomeButtonType.settings:
        return HomeStrings.settings.tr;
      case HomeButtonType.about:
        return HomeStrings.about.tr;
      case HomeButtonType.liked:
        return HomeStrings.likedTheGame.tr;
    }
  }

  Color get color {
    switch (this) {
      case HomeButtonType.newGame:
        return Colors.blue;
      case HomeButtonType.loadGame:
        return Colors.green;
      case HomeButtonType.settings:
        return Colors.orange;
      case HomeButtonType.about:
        return Colors.red;
      case HomeButtonType.liked:
        return Colors.yellow;
    }
  }
}
