import 'package:flup_sudoku/common/interfaces/abstract_translations.dart';
import 'package:get/get.dart';

class HomeTranslations extends AbstractTranslations {
  @override
  Map<Enum, String> get enUs => {
        HomeStrings.newGame: 'New Game',
        HomeStrings.loadGame: 'Load Game',
        HomeStrings.settings: 'Settings',
        HomeStrings.about: 'About',
        HomeStrings.likedTheGame: 'Liked the game?',
        HomeStrings.marketingDisclaimer: 'This game does not contain any ads. If you liked it, please consider supporting the developer.',
      };

  @override
  Map<Enum, String> get ptBr => {
        HomeStrings.newGame: 'Novo Jogo',
        HomeStrings.loadGame: 'Carregar Jogo',
        HomeStrings.settings: 'Configurações',
        HomeStrings.about: 'Sobre',
        HomeStrings.likedTheGame: 'Gostou do jogo?',
        HomeStrings.marketingDisclaimer: 'Esse jogo não contém nenhuma publicidade. Caso tenha gostado de jogar, considere apoiar o desenvolvedor.',
      };
}

enum HomeStrings {
  newGame,
  loadGame,
  settings,
  about,
  likedTheGame,
  marketingDisclaimer,
}

extension HomeStringsExtension on HomeStrings {
  String get tr => toString().tr;
}
