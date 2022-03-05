import 'package:flup_sudoku/ui/game/game_bindings.dart';
import 'package:flup_sudoku/ui/game/game_view.dart';
import 'package:flup_sudoku/ui/home/home_bindings.dart';
import 'package:flup_sudoku/ui/home/home_view.dart';
import 'package:get/get.dart';

class Pages {
  static get get => [
        GetPage(name: PageNames.home.route, page: () => const HomeView(), binding: HomeBindings()),
        GetPage(name: PageNames.game.route, page: () => const GameView(), binding: GameBindings()),
      ];
}

enum PageNames {
  home,
  about,
  game,
}

extension PageNamesExt on PageNames {
  String get route => '/${name.replaceAll('_', '/')}';
}
