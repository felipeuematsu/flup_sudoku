import 'package:flup_sudoku/common/interfaces/abstract_translations.dart';
import 'package:get/get.dart';

class GameTranslations extends AbstractTranslations {
  @override
  // TODO: implement enUs
  Map<Enum, String> get enUs => {
    GameStrings.id: 'Id:',
    GameStrings.time: 'Time:',
    GameStrings.mistakes: 'Mistakes:',
  };

  @override
  Map<Enum, String> get ptBr => {
    GameStrings.id: 'ID:',
    GameStrings.time: 'Tempo:',
    GameStrings.mistakes: 'Erros:',
  };
}

enum GameStrings {
  mistakes,
  id,
  time,
}

extension GameStringsExtension on GameStrings {
  String get tr => toString().tr;
}
