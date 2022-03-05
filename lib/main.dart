import 'package:flup_sudoku/config/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(FlupSudoku());
}

class FlupSudoku extends StatelessWidget {
  const FlupSudoku({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FlupSudoku',
      getPages: Pages.get,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

