import 'package:flup_sudoku/ui/home/home_view.dart';
import 'package:get/get.dart';

class Pages {
  static get get => [
    GetPage(name: PageNames.home.route, page: () => HomeView())
  ];
}

enum PageNames {
  home
}

extension PageNamesExt on PageNames {
  String get route => '/${name.replaceAll('_', '/')}';
}