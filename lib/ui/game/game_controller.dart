import 'package:flup_sudoku/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The GameController is the main class that controls the flow of the game.
class GameController extends GetxController with GetTickerProviderStateMixin {
  late List<List<int>> _answer;
  late List<List<int>> _initialState;
  final _currentState = Rx<List<List<int>>>([]);
  final _guesses = Rx<List<List<List<int>>>>([]);

  final mistakes = Rx<int>(0);

  final selectedRow = Rx<int>(-1);
  final selectedColumn = Rx<int>(-1);

  late Animation<double> verticalAnimation;
  late Animation<double> horizontalAnimation;
  late AnimationController _horizontalAnimationController;
  late AnimationController _verticalAnimationController;

  static const _animationDuration = Duration(milliseconds: 200);

  @override
  void onInit() {
    _verticalAnimationController = AnimationController(vsync: this, duration: _animationDuration);
    _horizontalAnimationController = AnimationController(vsync: this, duration: _animationDuration);
    verticalAnimation = Tween<double>(begin: -1, end: 8).animate(_verticalAnimationController)..addListener(() => update());
    horizontalAnimation = Tween<double>(begin: -1, end: 8).animate(_horizontalAnimationController)..addListener(() => update());
    super.onInit();
  }

  int _getCurrentValue(row, column) => _currentState.value[row][column];

  String _getCurrentGuess(int row, int column) {
    String result = '';
    for (int i = 0; i < 9; i++) {
      result += _guesses.value[row][column].contains(i) ? i.toString() : ' ';
      result += (i + 1) % 3 == 0 ? '\n' : ' ';
    }
    return result;
  }

  String getCellValue(int row, int column) => _getCurrentValue(row, column) == 0 ? _getCurrentGuess(row, column) : _getCurrentValue(row, column).toString();

  bool isWrong(int row, int column) => _getCurrentValue(row, column) != _answer[row][column];

  bool isSelected(int row, int column) => selectedColumn.value == column && selectedRow.value == row;

  bool isLineSelected(int row, int column) => selectedColumn.value == column || selectedRow.value == row;

  Function()? select(int row, int column) =>
      // _initialState[row][column] > 0
      // ? null:
      () {
        final verticalDiff = (selectedRow.value - row).abs();
        final horizontalDiff = (selectedColumn.value - column).abs();

        if (horizontalDiff != 0) {
          _horizontalAnimationController.animateTo((column + 1) / 9, duration: Duration(milliseconds: (_animationDuration.inMilliseconds * horizontalDiff) ~/ 9));
          selectedColumn.value = column;
        }
        if (verticalDiff != 0) {
          _verticalAnimationController.animateTo((row + 1) / 9, duration: Duration(milliseconds: (_animationDuration.inMilliseconds * verticalDiff) ~/ 9));
          selectedRow.value = row;
        }
      };

  void guess(int guess) {
    final row = selectedRow.value;
    final column = selectedColumn.value;
    if (row == -1 || column == -1 || _getCurrentValue(row, column) > 0) return;

    if (_guesses.value[row][column].contains(guess)) {
      _guesses.value[row][column].remove(guess);
    } else {
      _guesses.value[row][column].add(guess);
    }
  }

  void insertAnswer(int answer) {
    final row = selectedRow.value;
    final column = selectedColumn.value;
    if (row == -1 || column == -1 || _initialState[row][column] != 0 || _answer[row][column] == _getCurrentValue(row, column)) return;

    _currentState.value[row][column] = answer;
    if (answer != _answer[row][column]) mistakes.value++;
  }
}
