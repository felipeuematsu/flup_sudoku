import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flup_sudoku/ui/game/game_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GameAppBar extends AppBar {
  GameAppBar({Key? key, required this.controller})
      : super(
          key: key,
          backgroundColor: Colors.transparent,
          titleTextStyle: Get.textTheme.labelSmall,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Text('${GameStrings.id.tr} ${controller.model.id}'),
                onTap: () => Clipboard.setData(ClipboardData(text: controller.model.id.toString())),
              ),
              Obx(() => Text('${GameStrings.time.tr} ${controller.elapsedTime}')),
              Obx(() => Text('${GameStrings.mistakes.tr} ${controller.mistakes}')),
            ],
          ),
        );

  final GameController controller;


}
