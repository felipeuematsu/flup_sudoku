import 'package:flup_sudoku/common/pages.dart';
import 'package:flup_sudoku/common/strings.dart';
import 'package:flup_sudoku/common/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FlupSudoku());
}

class FlupSudoku extends StatelessWidget {
  const FlupSudoku({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flup Sudoku',
      locale: const Locale('en', 'US'),
      translations: Strings(),
      getPages: Pages.get,
      initialRoute: PageNames.game.route,
      theme: ThemeData(
        scaffoldBackgroundColor: lightColorScheme.background,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.robotoTextTheme()
      ),
    );
  }
}

