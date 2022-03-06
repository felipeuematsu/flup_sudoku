import 'package:flup_sudoku/ui/home/components/home_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late Animation<double> textAnimation;
  late AnimationController _animationController;

  static const _animationDuration = Duration(milliseconds: 4000);

  @override
  void onInit() {
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    textAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController)..addListener(() => update());
    super.onInit();
    continuousAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> continuousAnimation() async {
    _animationController.forward();
    await Future.delayed(_animationDuration);
    _animationController.reverse();
    await Future.delayed(_animationDuration);
    continuousAnimation();
  }

  void onButtonPressed(HomeButtonType type) {
    switch (type) {
      case HomeButtonType.newGame:
        Get.offAllNamed('/game');
        break;
      case HomeButtonType.loadGame:
        Get.offAllNamed('/load');
        break;
      case HomeButtonType.settings:
        Get.offAllNamed('/settings');
        break;
      case HomeButtonType.about:
        Get.offAllNamed('/about');
        break;
    }
  }
}
