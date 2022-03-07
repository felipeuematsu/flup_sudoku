import 'dart:async';

import 'package:flup_sudoku/model/sudoku_model.dart';
import 'package:flup_sudoku/ui/game/components/congratulations_popup.dart';
import 'package:flup_sudoku/ui/game/components/game_cell.dart';
import 'package:flup_sudoku/ui/game/components/game_control_button.dart';
import 'package:flup_sudoku/ui/game/controller/game_animation_controller.dart';
import 'package:get/get.dart';

/// The GameController is the main class that controls the flow of the game.
class GameController extends GetxController with GetTickerProviderStateMixin {
  late final SudokuModel model;

  final animationController = Get.find<GameAnimationController>();

  List<List<int>> get _answer => model.answerAsList;

  List<List<int>> get _initialState => model.initalStateAsList;
  final List<List<Rx<int>>> _currentState = [];
  final List<List<Rx<Map<int, InsertMode>>>> _guesses = [];

  final hints = true.obs;
  final _insertMode = InsertMode.guess.obs;

  set insertMode(InsertMode mode) => _insertMode.value = mode;

  InsertMode get insertMode => _insertMode.value;

  bool get isGuessing => insertMode == InsertMode.guess;

  bool get isAntiGuessing => insertMode == InsertMode.antiGuess;

  bool get isInserting => insertMode == InsertMode.insert;

  final _mistakes = 0.obs;
  final _time = 0.obs;

  final selectedRow = (-1).obs;
  final selectedColumn = (-1).obs;
  bool isGameRunning = true;

  String get mistakes => _mistakes.value.toString();

  String get elapsedTime => Duration(seconds: _time.value).toString().substring(_time.value < 3600 ? 2 : 0, 7);


  Map<int, InsertMode> get selectedCellValue => getCellValue(selectedRow.value, selectedColumn.value);

  @override
  void onInit() {
    Timer.periodic(const Duration(seconds: 1), (_) => isGameRunning ? _time.value++ : null);

    model = SudokuModel.fromCSVLine(
        '1,1..5.37..6.3..8.9......98...1.......8761..........6...........7.8.9.76.47...6.312,198543726643278591527619843914735268876192435235486179462351987381927654759864312,27,2.2');

    for (int row = 0; row < 9; row++) {
      _guesses.add([]);
      _currentState.add([]);
      for (int column = 0; column < 9; column++) {
        _guesses[row].add(Rx<Map<int, InsertMode>>({}));
        _currentState[row].add(Rx<int>(model.initalStateAsList[row][column]));
      }
    }
    super.onInit();
  }

  int _getCurrentValue(row, column) => row < 0 || column < 0 ? 0 : _currentState[row][column].value;

  Map<int, InsertMode> getCellValue(int row, int column) {
    if (row < 0 || column < 0) return {};
    if (_getCurrentValue(row, column) != 0) return {_getCurrentValue(row, column): InsertMode.insert};
    return _guesses[row][column].value.map((int key, InsertMode value) => MapEntry<int, InsertMode>(key, value));
  }

  bool isWrong(int row, int column) => _getCurrentValue(row, column) != 0 && _getCurrentValue(row, column) != _answer[row][column];

  bool isCorrect(int row, int column) => _getCurrentValue(row, column) != 0 && _getCurrentValue(row, column) == _answer[row][column];

  bool isInitial(int row, int column) => _initialState[row][column] != 0;

  bool isSelected(int row, int column) => selectedColumn.value == column && selectedRow.value == row;

  void Function()? onGameControlButtonPressed(GameControlType type) {
    switch (type) {
      case GameControlType.guess:
        return insertMode != InsertMode.guess ? () => insertMode = InsertMode.guess : null;
      case GameControlType.antiGuess:
        return insertMode != InsertMode.antiGuess ? () => insertMode = InsertMode.antiGuess : null;
      case GameControlType.insert:
        return insertMode != InsertMode.insert ? () => insertMode = InsertMode.insert : null;
      case GameControlType.clear:
        return getCellValue(selectedRow.value, selectedColumn.value).isNotEmpty ? () => _cleanCell() : null;
    }
  }

  void Function() onNumberButtonPressed(int value) => () => insertMode == InsertMode.insert ? insertAnswer(value) : insertGuess(value);

  void Function() onGameCellPressed(int row, int column) => () {
        final verticalDiff = (selectedRow.value - row).abs();
        final horizontalDiff = (selectedColumn.value - column).abs();

        if (horizontalDiff != 0) {
          animationController.horizontalAnimateTo((column + 1) / 9, horizontalDiff);
          selectedColumn.value = column;
        }
        if (verticalDiff != 0) {
          animationController.verticalAnimateTo((row + 1) / 9, verticalDiff);
          selectedRow.value = row;
        }
      };

  void _checkWinCondition() {
    for (int row = 0; row < 9; row++) {
      for (int column = 0; column < 9; column++) {
        if (_getCurrentValue(row, column) != _answer[row][column]) return;
      }
    }
    isGameRunning = false;
    CongratulationsPopup.showPopup(_time.value ~/ 60, _time.value % 60, _mistakes.value);
  }

  void _cleanCell() {
    if (!isGameRunning) return;

    final row = selectedRow.value, column = selectedColumn.value;

    if (isCorrect(row, column) && hints.isTrue) return;

    _guesses[row][column].value = {};
    _currentState[row][column].value = 0;
  }

  void insertGuess(int guess) {
    if (!isGameRunning) return;

    final row = selectedRow.value, column = selectedColumn.value;
    if (row == -1 || column == -1 || _getCurrentValue(row, column) > 0) return;

    final value = _guesses[row][column].value[guess];
    if (value == null) return _guesses[row][column].update((val) => val?.putIfAbsent(guess, () => insertMode));

    _guesses[row][column].update((val) {
      if (insertMode == value) {
        val?.remove(guess);
      } else {
        val?[guess] = value == InsertMode.guess ? InsertMode.antiGuess : InsertMode.guess;
      }
    });
  }

  void insertAnswer(int answer) {
    if (!isGameRunning) return;

    final row = selectedRow.value, column = selectedColumn.value;

    if (row == -1 || column == -1 || _initialState[row][column] != 0 || _answer[row][column] == _getCurrentValue(row, column) || answer == _getCurrentValue(row, column)) return;

    _guesses[row][column].value = {};
    _currentState[row][column].value = answer;
    if (answer != _answer[row][column]) _mistakes.value++;
    _checkWinCondition();
  }

  GameCellValueType getContentType(int row, int column) {
    if (isInitial(row, column)) return GameCellValueType.initial;
    if (hints.isTrue && isWrong(row, column)) return GameCellValueType.wrong;
    if (hints.isTrue && isCorrect(row, column)) return GameCellValueType.correct;
    if (isSelected(row, column)) return GameCellValueType.selected;

    return GameCellValueType.normal;
  }
}

enum InsertMode {
  guess,
  insert,
  antiGuess,
}
