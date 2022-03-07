import 'package:flup_sudoku/common/strings.dart';
import 'package:flup_sudoku/ui/game/controller/game_controller.dart';
import 'package:flup_sudoku/ui/game/game_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationsPopup extends GetView<GameController> {
  const CongratulationsPopup({this.minutes = 0, required this.seconds, required this.mistakes, Key? key}) : super(key: key);

  final int minutes;
  final int seconds;
  final int mistakes;

  static showPopup(int minutes, int seconds, int mistakes) async =>
      Get.dialog(CongratulationsPopup(mistakes: mistakes, minutes: minutes, seconds: seconds), barrierDismissible: false, useSafeArea: true);

  String get _message => GameStrings.congratulationsMessage.tr.replaceFirst('{0}', minutes.toString()).replaceFirst('{1}', seconds.toString()).replaceFirst('{2}', mistakes.toString());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(GameStrings.congratulationsTitle.tr, style: Get.textTheme.titleLarge),
      content: Text(_message, style: Get.textTheme.bodyMedium),
      actions: [
        MaterialButton(
          color: Colors.green,
          child: Text(CommonStrings.confirm.tr, style: Get.textTheme.button?.copyWith(color: Colors.white)),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
