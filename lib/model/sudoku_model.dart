import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class SudokuModel {
  SudokuModel({required this.id, required this.initialState, required this.completedState, required this.difficulty});

  @HiveField(0, defaultValue: 0)
  final int id;

  @HiveField(1, defaultValue: [])
  final List<List<int>> initialState;

  @HiveField(2, defaultValue: [])
  final List<List<int>> completedState;

  @HiveField(3, defaultValue: 0)
  final int difficulty;

}
