import 'package:flup_sudoku/common/interfaces/abstract_translations.dart';
import 'package:flup_sudoku/ui/game/game_strings.dart';
import 'package:flup_sudoku/ui/home/home_strings.dart';
import 'package:get/get.dart';

class Strings extends Translations {
  List<AbstractTranslations> get _strings => [
        CommonTranslations(),
        HomeTranslations(),
        GameTranslations(),
      ];

  @override
  Map<String, Map<String, String>> get keys => _strings.fold<Map<String, Map<String, String>>>({}, (value, translations) => translations.keys.map((k, v) => MapEntry(k, {...value[k] ?? {}, ...v})));
}

enum CommonStrings {
  flupSudoku,
  flup,
  sudoku,
  activated,
  deactivated,
}

extension CommonStringsExt on CommonStrings {
  String get tr => toString().tr;
}

class CommonTranslations extends AbstractTranslations {
  @override
  Map<Enum, String> get enUs => {
        CommonStrings.flupSudoku: 'FLUP Sudoku',
        CommonStrings.flup: 'FLUP ',
        CommonStrings.sudoku: 'Sudoku',
        CommonStrings.activated: 'Activated',
        CommonStrings.deactivated: 'Deactivated',
      };

  @override
  Map<Enum, String> get ptBr => {
        CommonStrings.flupSudoku: 'FLUP Sudoku',
        CommonStrings.flup: 'FLUP ',
        CommonStrings.sudoku: 'Sudoku',
        CommonStrings.activated: 'Ativado',
        CommonStrings.deactivated: 'Desativado',
      };
}
