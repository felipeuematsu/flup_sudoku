import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class SudokuModel {
  SudokuModel({required this.id, required this.initialState, required this.completedState, required this.difficulty});

  @HiveField(0, defaultValue: 0)
  final int id;

  @HiveField(1, defaultValue: '')
  final String initialState;

  @HiveField(2, defaultValue: '')
  final String completedState;

  @HiveField(3, defaultValue: 0)
  final int difficulty;

  List<List<int>> get initalStateAsList => initialState.split('').map((e) => int.tryParse(e) ?? 0).fold(<List<int>>[[]], (value, element) {
    if (value is List<List<int>>) value.last.length < 9 ? value.last.add(element) : value.add([element]);
    return value;
  }) ?? [];

  List<List<int>> get answerAsList => completedState.split('').map((e) => int.tryParse(e) ?? 0).fold(<List<int>>[[]], (value, element) {
    if (value is List<List<int>>) value.last.length < 9 ? value.last.add(element) : value.add([element]);
    return value;
  }) ?? [];

  static SudokuModel fromCSVLine(String line) {
    final list = line.split(',');

    final initialState = list[1].replaceAll('.', '0');
    final completedState = list[2];

    return SudokuModel(
      id: list[0].isEmpty ? 0 : int.tryParse(list[0]) ?? 0,
      completedState: completedState,
      initialState: initialState,
      difficulty: list[3].isEmpty ? 0 : int.tryParse(list[4]) ?? 0,
    );
  }
}
