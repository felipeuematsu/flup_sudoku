import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameAnimationController extends GetxController with GetTickerProviderStateMixin {
  late Animation<double> verticalAnimation;
  late Animation<double> horizontalAnimation;
  late AnimationController _horizontalAnimationController;
  late AnimationController _verticalAnimationController;

  static const _animationDuration = Duration(milliseconds: 350);

  void horizontalAnimateTo(double value, int horizontalDiff) {
    _horizontalAnimationController.animateTo(value, duration: Duration(milliseconds: (_animationDuration.inMilliseconds * horizontalDiff) ~/ 9), curve: Curves.easeInOut);
  }

  void verticalAnimateTo(double value, int verticalDiff) {
    _verticalAnimationController.animateTo(value, duration: Duration(milliseconds: (_animationDuration.inMilliseconds * verticalDiff) ~/ 9), curve: Curves.easeInOut);
  }

  @override
  void onInit() {
    _verticalAnimationController = AnimationController(vsync: this, duration: _animationDuration);
    _horizontalAnimationController = AnimationController(vsync: this, duration: _animationDuration);
    verticalAnimation = Tween<double>(begin: -1, end: 8).animate(_verticalAnimationController)..addListener(() => update());
    horizontalAnimation = Tween<double>(begin: -1, end: 8).animate(_horizontalAnimationController)..addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    _verticalAnimationController.dispose();
    _horizontalAnimationController.dispose();
    super.dispose();
  }
}
