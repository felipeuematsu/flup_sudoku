import 'package:flup_sudoku/common/interfaces/abstract_translations.dart';
import 'package:get/get.dart';

class GameTranslations extends AbstractTranslations {
  @override
  Map<Enum, String> get enUs => {
    GameStrings.id: 'Id:',
    GameStrings.time: 'Time:',
    GameStrings.mistakes: 'Mistakes:',
    GameStrings.congratulationsTitle: 'Congratulations!',
    GameStrings.congratulationsMessage: 'You completed the game in {0} minutes and {1} seconds with {2} mistakes.',
  };

  @override
  Map<Enum, String> get ptBr => {
    GameStrings.id: 'ID:',
    GameStrings.time: 'Tempo:',
    GameStrings.mistakes: 'Erros:',
    GameStrings.congratulationsTitle: 'Parabéns!',
    GameStrings.congratulationsMessage: 'Você completou o jogo em {0} minutos e {1} segundos com {2} erros.',
  };
}

enum GameStrings {
  mistakes,
  id,
  time,
  congratulationsTitle,
  congratulationsMessage,
}

extension GameStringsExtension on GameStrings {
  String get tr => toString().tr;
}
