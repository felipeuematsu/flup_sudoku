import 'dart:math';

import 'package:flup_sudoku/common/fonts.dart';
import 'package:flup_sudoku/common/strings.dart';
import 'package:flup_sudoku/ui/home/components/home_button.dart';
import 'package:flup_sudoku/ui/home/home_controller.dart';
import 'package:flup_sudoku/ui/home/home_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: controller.textAnimation,
                    builder: (context, Widget? widget) => Transform.rotate(
                      angle: pi / 36 * (2 * controller.textAnimation.value - 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(CommonStrings.flup.tr, style: Get.textTheme.displaySmall?.copyWith(fontFamily: Fonts.permanentMarker, color: Get.theme.colorScheme.primary)),
                          Text(CommonStrings.sudoku.tr, style: Get.textTheme.displaySmall?.copyWith(fontFamily: Fonts.permanentMarker, color: Get.theme.colorScheme.secondary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const HomeButton(type: HomeButtonType.newGame),
                  const HomeButton(type: HomeButtonType.loadGame),
                  const HomeButton(type: HomeButtonType.settings),
                  const HomeButton(type: HomeButtonType.about),
                  const HomeButton(type: HomeButtonType.liked),
                ],
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Text(
                  HomeStrings.marketingDisclaimer.tr,
                  style: Get.textTheme.labelSmall,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
