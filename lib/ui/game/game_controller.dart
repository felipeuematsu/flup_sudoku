import 'package:flup_sudoku/model/sudoku_model.dart';
import 'package:flup_sudoku/ui/game/components/game_cell.dart';
import 'package:flup_sudoku/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The GameController is the main class that controls the flow of the game.
class GameController extends GetxController with GetTickerProviderStateMixin {
  late final SudokuModel model;

  List<List<int>> get _answer => model.answerAsList;

  List<List<int>> get _initialState => model.initalStateAsList;
  final _currentState = Rx<List<List<int>>>([]);
  final _guesses = Rx<List<List<Map<int, bool>>>>([
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
    [{}, {}, {}, {}, {}, {}, {}, {}, {}],
  ]);

  final guessMode = GuessMode.guess.obs;

  final mistakes = Rx<int>(0);

  final selectedRow = Rx<int>(-1);
  final selectedColumn = Rx<int>(-1);

  Map<int, GuessMode> get selectedCellValue => getCellValue(selectedRow.value, selectedColumn.value);

  late Animation<double> verticalAnimation;
  late Animation<double> horizontalAnimation;
  late AnimationController _horizontalAnimationController;
  late AnimationController _verticalAnimationController;

  static const _animationDuration = Duration(milliseconds: 350);

  @override
  void onInit() {
    _verticalAnimationController = AnimationController(vsync: this, duration: _animationDuration);
    _horizontalAnimationController = AnimationController(vsync: this, duration: _animationDuration);
    verticalAnimation = Tween<double>(begin: -1, end: 8).animate(_verticalAnimationController)..addListener(() => update());
    horizontalAnimation = Tween<double>(begin: -1, end: 8).animate(_horizontalAnimationController)..addListener(() => update());

    model = SudokuModel.fromCSVLine(
        '1,1..5.37..6.3..8.9......98...1.......8761..........6...........7.8.9.76.47...6.312,198543726643278591527619843914735268876192435235486179462351987381927654759864312,27,2.2');

    _currentState.value = model.initalStateAsList;
    super.onInit();
  }

  int _getCurrentValue(row, column) => selectedRow.value < 0 || selectedColumn.value < 0 ? 0 : _currentState.value[row][column];

  Map<int, GuessMode> getCellValue(int row, int column) {
    if (_getCurrentValue(row, column) != 0) return {_getCurrentValue(row, column): GuessMode.insert};
    if (selectedRow.value < 0 || selectedColumn.value < 0) return {};
    return _guesses.value[row][column].map((key, value) => MapEntry<int, GuessMode>(key, value ? GuessMode.guess : GuessMode.antiGuess));
  }

  bool isWrong(int row, int column) => _getCurrentValue(row, column) != 0 && _getCurrentValue(row, column) != _answer[row][column];

  bool isCorrect(int row, int column) => _getCurrentValue(row, column) != 0 && _getCurrentValue(row, column) == _answer[row][column];

  bool isInitial(int row, int column) => _initialState[row][column] != 0;

  bool isSelected(int row, int column) => selectedColumn.value == column && selectedRow.value == row;

  Function()? select(int row, int column) => () {
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

  Function() onNumberButtonPressed(int value) => guessMode.value == GuessMode.insert ? () => insertAnswer(value) : () => guess(value);

  void guess(int guess) {
    final row = selectedRow.value;
    final column = selectedColumn.value;
    if (row == -1 || column == -1 || _getCurrentValue(row, column) > 0) return;

    final value = _guesses.value[row][column][guess];
    if (value != null) {
      final guessType = value ? GuessMode.guess : GuessMode.antiGuess;

      if (guessMode.value == guessType) {
        _guesses.value[row][column].remove(guess);
      } else {
        _guesses.value[row][column][guess] = !value;
      }
    } else {
      _guesses.value[row][column].putIfAbsent(guess, () => guessMode.value == GuessMode.guess);
    }

    refresh();
  }

  void insertAnswer(int answer) {
    final row = selectedRow.value;
    final column = selectedColumn.value;

    logger.i(answer);
    logger.i(_currentState.value);
    logger.i(_initialState);
    if (row == -1 || column == -1 || _initialState[row][column] != 0 || _answer[row][column] == _getCurrentValue(row, column) || answer == _getCurrentValue(row, column)) return;

    logger.i(answer);
    logger.i(_currentState.value);
    logger.i(_initialState.toString());
    _currentState.update((val) => val?[row][column] = answer);
    if (answer != _answer[row][column]) mistakes.value++;
  }

  GameCellValueType contentType(int row, int column) {
    if (isInitial(row, column)) return GameCellValueType.initial;
    if (getCellValue(row, column).length > 1) return GameCellValueType.guess;
    if (isWrong(row, column)) return GameCellValueType.wrong;
    if (isCorrect(row, column)) return GameCellValueType.correct;
    if (isSelected(row, column)) return GameCellValueType.selected;

    return GameCellValueType.normal;
  }
}

enum GuessMode {
  guess,
  insert,
  antiGuess,
}
