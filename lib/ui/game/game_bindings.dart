import 'package:flup_sudoku/ui/game/controller/game_animation_controller.dart';
import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:get/get.dart';

class GameBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController());
    Get.lazyPut<GameAnimationController>(() => GameAnimationController());
  }
}
