import 'package:flup_sudoku/ui/game/game_controller.dart';
import 'package:get/get.dart';

class GameBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController());
  }
}
